defmodule Watchnature.Repo.Migrations.CreateWatchnature.Taxonomies.Species do
  use Ecto.Migration

  def change do
    create table(:taxonomies_species) do
      add :name, :string

      timestamps()
    end

  end
end
