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
  end

  def top_three do

    query = """
      select winner_id, count(*) as count
      from matches
      group by winner_id
      order by count desc
      limit 3;
    """
    result = Ecto.Adapters.SQL.query(Repo, query)


  end
end
