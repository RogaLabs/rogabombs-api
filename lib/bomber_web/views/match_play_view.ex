defmodule BomberWeb.MatchPlayView do
  use BomberWeb, :view
  alias BomberWeb.MatchPlayView

  def render("index.json", %{matches_plays: matches_plays}) do
    %{data: render_many(matches_plays, MatchPlayView, "match_play.json")}
  end

  def render("show.json", %{match_play: match_play}) do
    %{data: render_one(match_play, MatchPlayView, "match_play.json")}
  end

  def render("match_play.json", %{match_play: match_play}) do
    %{id: match_play.id,
      score: match_play.score}
  end
end
