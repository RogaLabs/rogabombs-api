defmodule BomberWeb.PlayerController do
  use BomberWeb, :controller

  alias Bomber.Ranking
  alias Bomber.Ranking.Player

  action_fallback BomberWeb.FallbackController

  def index(conn, _params) do
    players = Ranking.list_players()
    render(conn, "index.json", players: players)
  end

  def create(conn, %{"player" => player_params}) do
    with {:ok, %Player{} = player} <- Ranking.create_player(player_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", player_path(conn, :show, player))
      |> render("show.json", player: player)
    end
  end

  def show(conn, %{"id" => id}) do
    player = Ranking.get_player!(id)
    render(conn, "show.json", player: player)
  end

  def update(conn, %{"id" => id, "player" => player_params}) do
    player = Ranking.get_player!(id)

    with {:ok, %Player{} = player} <- Ranking.update_player(player, player_params) do
      render(conn, "show.json", player: player)
    end
  end

  def delete(conn, %{"id" => id}) do
    player = Ranking.get_player!(id)
    with {:ok, %Player{}} <- Ranking.delete_player(player) do
      send_resp(conn, :no_content, "")
    end
  end

  def hall_of_fame(conn, _params) do
    players = Player.top_three()
    conn
    |> render("hall.json", players: players)
  end

  def hall_of_shame(conn, _params) do
    players = Player.down_three()
    conn
    |> render("hall.json", players: players)
  end
end
