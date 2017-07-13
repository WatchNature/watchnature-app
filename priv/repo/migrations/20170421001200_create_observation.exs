defmodule Watchnature.Repo.Migrations.CreateObservation do
  use Ecto.Migration

  def change do
    create table(:observations) do
      add :description, :text
      add :location_name, :string
      add :location, :geometry
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:observations, [:post_id])
  end
end
