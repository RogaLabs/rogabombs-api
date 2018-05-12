defmodule BomberWeb.MatchPlayControllerTest do
  use BomberWeb.ConnCase

  alias Bomber.Ranking
  alias Bomber.Ranking.MatchPlay

  @create_attrs %{score: 42}
  @update_attrs %{score: 43}
  @invalid_attrs %{score: nil}

  def fixture(:match_play) do
    {:ok, match_play} = Ranking.create_match_play(@create_attrs)
    match_play
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all matches_plays", %{conn: conn} do
      conn = get conn, match_play_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create match_play" do
    test "renders match_play when data is valid", %{conn: conn} do
      conn = post conn, match_play_path(conn, :create), match_play: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, match_play_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "score" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, match_play_path(conn, :create), match_play: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update match_play" do
    setup [:create_match_play]

    test "renders match_play when data is valid", %{conn: conn, match_play: %MatchPlay{id: id} = match_play} do
      conn = put conn, match_play_path(conn, :update, match_play), match_play: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, match_play_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "score" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, match_play: match_play} do
      conn = put conn, match_play_path(conn, :update, match_play), match_play: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete match_play" do
    setup [:create_match_play]

    test "deletes chosen match_play", %{conn: conn, match_play: match_play} do
      conn = delete conn, match_play_path(conn, :delete, match_play)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, match_play_path(conn, :show, match_play)
      end
    end
  end

  defp create_match_play(_) do
    match_play = fixture(:match_play)
    {:ok, match_play: match_play}
  end
end
