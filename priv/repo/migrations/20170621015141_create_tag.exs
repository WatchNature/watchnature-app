defmodule Watchnature.Repo.Migrations.CreateTag do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string
      add :type, :integer

      timestamps()
    end

  end
end
