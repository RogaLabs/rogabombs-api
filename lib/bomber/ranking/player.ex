defmodule Bomber.Ranking.Player do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Bomber.Ranking.MatchPlay
  alias Bomber.Ranking.Match
  alias Bomber.Repo
  alias Bomber.Ranking.Player

  schema "players" do
    field :name, :string
    has_many :matches_plays, MatchPlay

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def top_three do

    today = DateTime.utc_now()
    query = from(m in Match,
                 select: %{winner_id: m.winner_id, count: count("*")},
                 where: fragment("Extract(month from ?)", m.date) == ^today.month,
                 where: fragment("Extract(year from ?)", m.date) == ^today.year,
                 group_by: [m.winner_id],
                 order_by: [desc: count("*")])
    Repo.all(query)
    |> Enum.take(3)
    |> Enum.map( fn( %{winner_id: id, count: wins} ) ->
      player = Player
               |> Repo.get(id)
               |> Repo.preload(:matches_plays)
      [player, wins]
    end)
  end

  def down_three do

    today = DateTime.utc_now()
    query = from(m in Match,
                 select: %{winner_id: m.winner_id, count: count("*")},
                 where: fragment("Extract(month from ?)", m.date) == ^today.month,
                 where: fragment("Extract(year from ?)", m.date) == ^today.year,
                 group_by: [m.winner_id],
                 order_by: [asc: count("*")])
    Repo.all(query)
    |> Enum.take(3)
    |> Enum.map( fn(%{winner_id: id, count: wins}) ->
      player = Player
               |> Repo.get(id)
               |> Repo.preload(:matches_plays)
      [player, wins]
    end)
  end
end
