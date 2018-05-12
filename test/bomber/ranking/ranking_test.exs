defmodule Bomber.RankingTest do
  use Bomber.DataCase

  alias Bomber.Ranking

  describe "players" do
    alias Bomber.Ranking.Player

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ranking.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Ranking.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Ranking.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Ranking.create_player(@valid_attrs)
      assert player.name == "some name"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ranking.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, player} = Ranking.update_player(player, @update_attrs)
      assert %Player{} = player
      assert player.name == "some updated name"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Ranking.update_player(player, @invalid_attrs)
      assert player == Ranking.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Ranking.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Ranking.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Ranking.change_player(player)
    end
  end

  describe "matches" do
    alias Bomber.Ranking.Match

    @valid_attrs %{date: "2010-04-17 14:00:00.000000Z", victory_type: 42}
    @update_attrs %{date: "2011-05-18 15:01:01.000000Z", victory_type: 43}
    @invalid_attrs %{date: nil, victory_type: nil}

    def match_fixture(attrs \\ %{}) do
      {:ok, match} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ranking.create_match()

      match
    end

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Ranking.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Ranking.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      assert {:ok, %Match{} = match} = Ranking.create_match(@valid_attrs)
      assert match.date == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert match.victory_type == 42
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ranking.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      assert {:ok, match} = Ranking.update_match(match, @update_attrs)
      assert %Match{} = match
      assert match.date == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert match.victory_type == 43
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Ranking.update_match(match, @invalid_attrs)
      assert match == Ranking.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Ranking.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Ranking.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Ranking.change_match(match)
    end
  end

  describe "matches_plays" do
    alias Bomber.Ranking.MatchPlay

    @valid_attrs %{score: 42}
    @update_attrs %{score: 43}
    @invalid_attrs %{score: nil}

    def match_play_fixture(attrs \\ %{}) do
      {:ok, match_play} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ranking.create_match_play()

      match_play
    end

    test "list_matches_plays/0 returns all matches_plays" do
      match_play = match_play_fixture()
      assert Ranking.list_matches_plays() == [match_play]
    end

    test "get_match_play!/1 returns the match_play with given id" do
      match_play = match_play_fixture()
      assert Ranking.get_match_play!(match_play.id) == match_play
    end

    test "create_match_play/1 with valid data creates a match_play" do
      assert {:ok, %MatchPlay{} = match_play} = Ranking.create_match_play(@valid_attrs)
      assert match_play.score == 42
    end

    test "create_match_play/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ranking.create_match_play(@invalid_attrs)
    end

    test "update_match_play/2 with valid data updates the match_play" do
      match_play = match_play_fixture()
      assert {:ok, match_play} = Ranking.update_match_play(match_play, @update_attrs)
      assert %MatchPlay{} = match_play
      assert match_play.score == 43
    end

    test "update_match_play/2 with invalid data returns error changeset" do
      match_play = match_play_fixture()
      assert {:error, %Ecto.Changeset{}} = Ranking.update_match_play(match_play, @invalid_attrs)
      assert match_play == Ranking.get_match_play!(match_play.id)
    end

    test "delete_match_play/1 deletes the match_play" do
      match_play = match_play_fixture()
      assert {:ok, %MatchPlay{}} = Ranking.delete_match_play(match_play)
      assert_raise Ecto.NoResultsError, fn -> Ranking.get_match_play!(match_play.id) end
    end

    test "change_match_play/1 returns a match_play changeset" do
      match_play = match_play_fixture()
      assert %Ecto.Changeset{} = Ranking.change_match_play(match_play)
    end
  end
end
