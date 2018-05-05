defmodule BomberWeb.PlayerControllerTest do
  use BomberWeb.ConnCase

  alias Bomber.Ranking
  alias Bomber.Ranking.Player

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:player) do
    {:ok, player} = Ranking.create_player(@create_attrs)
    player
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all players", %{conn: conn} do
      conn = get conn, player_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create player" do
    test "renders player when data is valid", %{conn: conn} do
      conn = post conn, player_path(conn, :create), player: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, player_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, player_path(conn, :create), player: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update player" do
    setup [:create_player]

    test "renders player when data is valid", %{conn: conn, player: %Player{id: id} = player} do
      conn = put conn, player_path(conn, :update, player), player: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, player_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, player: player} do
      conn = put conn, player_path(conn, :update, player), player: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete player" do
    setup [:create_player]

    test "deletes chosen player", %{conn: conn, player: player} do
      conn = delete conn, player_path(conn, :delete, player)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, player_path(conn, :show, player)
      end
    end
  end

  defp create_player(_) do
    player = fixture(:player)
    {:ok, player: player}
  end
end
