defmodule Bomber.Ranking.MatchPlay do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bomber.Ranking.Player
  alias Bomber.Ranking.Match


  schema "matches_plays" do
    field :score, :integer
    belongs_to :player, Player
    belongs_to :match, Match

    timestamps()
  end

  @doc false
  def changeset(match_play, attrs) do
    match_play
    |> cast(attrs, [:score, :player_id, :match_id])
    |> validate_required([:score,:player_id])
  end
end
