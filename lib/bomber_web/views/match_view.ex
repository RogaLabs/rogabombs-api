defmodule BomberWeb.MatchView do
  use BomberWeb, :view
  alias BomberWeb.{MatchView,MatchPlayView,PlayerView}
  import VictoryType
  def render("index.json", %{matches: matches}) do
    %{data: render_many(matches, MatchView, "match.json")}
  end

  def render("show.json", %{match: match}) do
    %{data: render_one(match, MatchView, "match.json")}
  end

  def render("match.json", %{match: match}) do
    %{id: match.id,
      date: match.date,
      victory_type: get_str_status(match.victory_type),
      winner: render_one(match.winner,PlayerView,"player.json"),
      matches_plays: render_many(match.matches_plays,MatchPlayView,"match_play.json")}
  end
end
