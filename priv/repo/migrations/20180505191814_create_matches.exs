defmodule Bomber.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :date, :utc_datetime
      add :victory_type, :integer

      timestamps()
    end

  end
end
