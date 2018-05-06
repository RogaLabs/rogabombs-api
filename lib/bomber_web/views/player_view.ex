defmodule BomberWeb.PlayerView do
  use BomberWeb, :view
  alias BomberWeb.PlayerView

  def render("index.json", %{players: players}) do
    %{data: render_many(players, PlayerView, "player.json")}
  end

  def render("show.json", %{player: player}) do
    %{data: render_one(player, PlayerView, "player.json")}
  end

  def render("player.json", %{player: player}) do
    %{id: player.id,
      name: player.name}
  end

  def render("hall_of_fame.json", %{players: players}) do
    Enum.map(players, fn( [ player, wins ] ) ->
      %{
        id: player.id,
        name: player.name,
        matches_plays_size: length(player.matches_plays),
        wins: wins
      }
    end)
  end
end
