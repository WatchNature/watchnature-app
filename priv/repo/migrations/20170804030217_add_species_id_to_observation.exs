defmodule Watchnature.Repo.Migrations.AddSpeciesIdToObservation do
  use Ecto.Migration

  def change do
    alter table(:observations) do
      add :species_id, references(:species, on_delete: :nothing)
    end

    create index(:observations, [:species_id])
  end
end
