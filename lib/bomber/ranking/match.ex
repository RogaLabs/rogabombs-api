defmodule Bomber.Ranking.Match do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bomber.Ranking.MatchPlay
  alias Bomber.Ranking.Player
  alias Bomber.Repo
  import VictoryType

  schema "matches" do
    field :date, :utc_datetime
    field :victory_type, :integer
    has_many :matches_plays, MatchPlay
    belongs_to :winner, Player
    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    attrs = Map.update(attrs, "victory_type", 1, &get_int_status/1)

    match
    |> cast(attrs, [:date, :victory_type])
    |> cast_assoc(:matches_plays)
    |> validate_required([:date, :victory_type])
    |> validate_four_players # min of 4 players and max of 5 players
    |> validate_and_set_winner # validate scores to define winner of match
    |> validate_victory_type # validate flawless victory
  end

  defp validate_four_players(changeset) do
    matches_plays = get_field(changeset,:matches_plays)
    cond do
    length(matches_plays) < 4 ->
      add_error(changeset, :matches_plays, "Minimum number of players is 4")
    length(matches_plays) > 5 ->
      add_error(changeset, :matches_plays, "Maximum number of players is 5")
    true ->
      changeset
    end
  end

  defp validate_and_set_winner(changeset) do
    matches_plays = get_field(changeset,:matches_plays)
    winners = for match_play <- matches_plays do
      if (match_play.score == 3) do
          match_play.player_id
      end
    end

    winners = Enum.filter(winners, fn(x) -> x != nil end)

    cond do
      length(winners) == 1 ->
        winner_id = List.first(winners)
        change(changeset,%{winner_id: winner_id})
      length(winners) < 1 ->
        add_error(changeset, :winner, "Match require a winner")
      length(winners) > 1 ->
        add_error(changeset, :winner, "Match require just one winner")
    end
  end

  defp validate_victory_type(changeset) do
    matches_plays = get_field(changeset,:matches_plays)

    total_points_match =
    matches_plays
    |> Enum.map(fn(x) -> x.score end)
    |> Enum.reduce(0,fn(x, acc) -> x + acc end)

    case total_points_match do
     3 ->
       victory_type = get_field(changeset,:victory_type)
       change(changeset,%{victory_type: victory_type + 2})
     _ ->
       changeset
    end

  end

end
