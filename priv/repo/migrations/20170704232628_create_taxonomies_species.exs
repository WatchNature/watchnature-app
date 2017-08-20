defmodule Watchnature.Repo.Migrations.CreateWatchnature.Taxonomies.Species do
  use Ecto.Migration

  def change do
    create table(:species) do
      add :common_name, :string
      add :scientific_name, :string
      add :itis_tsn, :integer

      timestamps()
    end

    create index(:species, [:common_name])
    create index(:species, [:scientific_name])
    create index(:species, [:common_name, :scientific_name])
    create index(:species, [:itis_tsn])
  end
end
