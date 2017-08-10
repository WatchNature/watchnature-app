defmodule Watchnature.Repo.Migrations.CreateWatchnature.Taxonomies.Species do
  use Ecto.Migration

  def change do
    create table(:species) do
      add :common_name, :string
      add :scientific_name, :string
      add :itis_tsn, :integer

      timestamps()
    end

    create index(:species, [fragment("lower(common_name)"])
    create inded(:species, [fragment("lower(scientific_name)"])
    create index(:species, [fragment("lower(common_name)"), fragment("lower(scientific_name)")])
    create index(:species, [:itis_tsn])
  end
end
