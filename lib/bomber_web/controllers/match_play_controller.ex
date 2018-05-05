defmodule BomberWeb.MatchPlayController do
  use BomberWeb, :controller

  alias Bomber.Ranking
  alias Bomber.Ranking.MatchPlay

  action_fallback BomberWeb.FallbackController

  def index(conn, _params) do
    matches_plays = Ranking.list_matches_plays()
    render(conn, "index.json", matches_plays: matches_plays)
  end

  def create(conn, %{"match_play" => match_play_params}) do
    with {:ok, %MatchPlay{} = match_play} <- Ranking.create_match_play(match_play_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", match_play_path(conn, :show, match_play))
      |> render("show.json", match_play: match_play)
    end
  end

  def show(conn, %{"id" => id}) do
    match_play = Ranking.get_match_play!(id)
    render(conn, "show.json", match_play: match_play)
  end

  def update(conn, %{"id" => id, "match_play" => match_play_params}) do
    match_play = Ranking.get_match_play!(id)

    with {:ok, %MatchPlay{} = match_play} <- Ranking.update_match_play(match_play, match_play_params) do
      render(conn, "show.json", match_play: match_play)
    end
  end

  def delete(conn, %{"id" => id}) do
    match_play = Ranking.get_match_play!(id)
    with {:ok, %MatchPlay{}} <- Ranking.delete_match_play(match_play) do
      send_resp(conn, :no_content, "")
    end
  end
end
