defmodule Watchnature.Repo.Migrations.CreateObservationTag do
  use Ecto.Migration

  def change do
    create table(:observation_tags) do
      add :observation_id, references(:observations, on_delete: :nothing)
      add :tag_id, references(:tags, on_delete: :nothing)

      timestamps()
    end
    create index(:observation_tags, [:observation_id])
    create index(:observation_tags, [:tag_id])

  end
end
