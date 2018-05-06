defmodule BomberWeb.MatchController do
  use BomberWeb, :controller

  alias Bomber.Ranking
  alias Bomber.Ranking.Match
  alias Bomber.Repo

  action_fallback BomberWeb.FallbackController

  def index(conn, _params) do
    matches = Ranking.list_matches()
    render(conn, "index.json", matches: matches)
  end

  def create(conn, %{"match" => match_params}) do
    with {:ok, %Match{} = match} <- Ranking.create_match(match_params) do
      match = Repo.preload(match, matches_plays: :player)
      conn
      |> put_status(:created)
      |> put_resp_header("location", match_path(conn, :show, match))
      |> render("show.json", match: match)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Ranking.get_match!(id)
    render(conn, "show.json", match: match)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Ranking.get_match!(id)

    with {:ok, %Match{} = match} <- Ranking.update_match(match, match_params) do
      render(conn, "show.json", match: match)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Ranking.get_match!(id)
    with {:ok, %Match{}} <- Ranking.delete_match(match) do
      send_resp(conn, :no_content, "")
    end
  end

  def last_match(conn, _params) do
    match = Ranking.last_match!()
    render(conn,"show.json", match: match)
  end

end
