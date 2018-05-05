defmodule Bomber.Repo.Migrations.AddWinnerToMatch do
  use Ecto.Migration

  def change do
    alter table(:matches) do
      add :winner_id, references(:players)
    end

    create index(:matches, [:winner_id])
  end
end
