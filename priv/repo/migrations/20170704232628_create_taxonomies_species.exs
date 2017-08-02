defmodule Watchnature.Repo.Migrations.CreateWatchnature.Taxonomies.Species do
  use Ecto.Migration

  def change do
    create table(:species) do
      add :common_name, :string
      add :scientific_name, :string
      add :itis_tsn, :integer

      timestamps()
    end

  end
end
