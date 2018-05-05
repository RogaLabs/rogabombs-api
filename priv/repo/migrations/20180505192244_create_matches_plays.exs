defmodule Bomber.Repo.Migrations.CreateMatchesPlays do
  use Ecto.Migration

  def change do
    create table(:matches_plays) do
      add :score, :integer
      add :player_id, references(:players, on_delete: :nothing)
      add :match_id, references(:matches, on_delete: :nothing)

      timestamps()
    end

    create index(:matches_plays, [:player_id])
    create index(:matches_plays, [:match_id])
  end
end
