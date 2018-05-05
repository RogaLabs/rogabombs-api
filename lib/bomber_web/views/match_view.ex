defmodule BomberWeb.MatchView do
  use BomberWeb, :view
  alias BomberWeb.MatchView

  def render("index.json", %{matches: matches}) do
    %{data: render_many(matches, MatchView, "match.json")}
  end

  def render("show.json", %{match: match}) do
    %{data: render_one(match, MatchView, "match.json")}
  end

  def render("match.json", %{match: match}) do
    %{id: match.id,
      date: match.date,
      victory_type: match.victory_type}
  end
end
