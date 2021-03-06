defmodule Bomber.Ranking do
  @moduledoc """
  The Ranking context.
  """

  import Ecto.Query, warn: false
  alias Bomber.Repo

  alias Bomber.Ranking.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Repo.all(Player)
    |> Repo.preload(:matches_plays)
    |> Enum.map(fn(player) ->
      wins = Enum.reduce(player.matches_plays,0, fn(match_play, acc) ->
                        if match_play.score == 3 do
                          acc + 1
                        else
                          acc
                        end
                      end
                    )
      matches_played = length(player.matches_plays)
      %{player| wins: wins,matches_played: matches_played}
    end
    )
  end


  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{source: %Player{}}

  """
  def change_player(%Player{} = player) do
    Player.changeset(player, %{})
  end

  alias Bomber.Ranking.Match

  @doc """
  Returns the list of matches.

  ## Examples

      iex> list_matches()
      [%Match{}, ...]

  """
  def list_matches do
    Repo.all(Match)
    |> Repo.preload(:winner)
    |> Repo.preload(matches_plays: [:player])
  end

  @doc """
  Gets a single match.

  Raises `Ecto.NoResultsError` if the Match does not exist.

  ## Examples

      iex> get_match!(123)
      %Match{}

      iex> get_match!(456)
      ** (Ecto.NoResultsError)

  """
  def get_match!(id), do: Repo.get!(Match, id)

  @doc """
  Creates a match.

  ## Examples

      iex> create_match(%{field: value})
      {:ok, %Match{}}

      iex> create_match(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_match(attrs \\ %{}) do
    %Match{}
    |> Match.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a match.

  ## Examples

      iex> update_match(match, %{field: new_value})
      {:ok, %Match{}}

      iex> update_match(match, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_match(%Match{} = match, attrs) do
    match
    |> Match.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Match.

  ## Examples

      iex> delete_match(match)
      {:ok, %Match{}}

      iex> delete_match(match)
      {:error, %Ecto.Changeset{}}

  """
  def delete_match(%Match{} = match) do
    Repo.delete(match)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking match changes.

  ## Examples

      iex> change_match(match)
      %Ecto.Changeset{source: %Match{}}

  """
  def change_match(%Match{} = match) do
    Match.changeset(match, %{})
  end

  def last_match!() do
   query = from( m in Match,
           order_by: [desc: m.date, desc: m.id],
           limit: 1,
           preload: [:winner, matches_plays: [:player]])
   Repo.one!(query)
  end

  def preload_match(match) do
    match
    |> Repo.preload(:winner)
    |> Repo.preload(matches_plays: [:player])
  end

  alias Bomber.Ranking.MatchPlay

  @doc """
  Returns the list of matches_plays.

  ## Examples

      iex> list_matches_plays()
      [%MatchPlay{}, ...]

  """
  def list_matches_plays do
    Repo.all(MatchPlay)
  end

  @doc """
  Gets a single match_play.

  Raises `Ecto.NoResultsError` if the Match play does not exist.

  ## Examples

      iex> get_match_play!(123)
      %MatchPlay{}

      iex> get_match_play!(456)
      ** (Ecto.NoResultsError)

  """
  def get_match_play!(id), do: Repo.get!(MatchPlay, id)

  @doc """
  Creates a match_play.

  ## Examples

      iex> create_match_play(%{field: value})
      {:ok, %MatchPlay{}}

      iex> create_match_play(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_match_play(attrs \\ %{}) do
    %MatchPlay{}
    |> MatchPlay.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a match_play.

  ## Examples

      iex> update_match_play(match_play, %{field: new_value})
      {:ok, %MatchPlay{}}

      iex> update_match_play(match_play, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_match_play(%MatchPlay{} = match_play, attrs) do
    match_play
    |> MatchPlay.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a MatchPlay.

  ## Examples

      iex> delete_match_play(match_play)
      {:ok, %MatchPlay{}}

      iex> delete_match_play(match_play)
      {:error, %Ecto.Changeset{}}

  """
  def delete_match_play(%MatchPlay{} = match_play) do
    Repo.delete(match_play)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking match_play changes.

  ## Examples

      iex> change_match_play(match_play)
      %Ecto.Changeset{source: %MatchPlay{}}

  """
  def change_match_play(%MatchPlay{} = match_play) do
    MatchPlay.changeset(match_play, %{})
  end
end
