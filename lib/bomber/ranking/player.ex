defmodule Bomber.Ranking.Player do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bomber.Ranking.MatchPlay

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
end
