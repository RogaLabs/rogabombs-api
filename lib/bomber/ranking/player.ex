defmodule Bomber.Ranking.Player do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bomber.Ranking.MatchPlay
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

    query = """
      select winner_id, count(*) as count
      from matches
      group by winner_id
      order by count desc
    """
    {:ok, %Postgrex.Result{rows: rows}} = Ecto.Adapters.SQL.query(Repo, query)
    rows
    |> Enum.with_index
    |> Enum.map( fn({ [player, wins], i }) ->
      if i <= 2 do
        [player, wins]
      end
    end)
    |> Enum.take(3)
    |> Enum.map( fn( [id, wins] ) ->
      player = Player
               |> Repo.get(id)
               |> Repo.preload(:matches_plays)
      [player, wins]
    end)
  end
end
