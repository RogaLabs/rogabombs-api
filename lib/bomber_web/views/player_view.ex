defmodule BomberWeb.PlayerView do
  use BomberWeb, :view
  alias BomberWeb.PlayerView

  def render("index.json", %{players: players}) do
    %{data: render_many(players, PlayerView, "player_with_wins.json")}
  end

  def render("show.json", %{player: player}) do
    %{data: render_one(player, PlayerView, "player.json")}
  end

  def render("player_with_wins.json", %{player: player}) do
    %{id: player.id,
      name: player.name,
      wins: player.wins,
      matches_played: player.matches_played}
  end

  def render("player.json", %{player: player}) do
    %{id: player.id,
      name: player.name}
  end

  def render("hall.json", %{players: players}) do
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
