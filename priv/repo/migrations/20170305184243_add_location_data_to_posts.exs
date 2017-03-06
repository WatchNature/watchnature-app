defmodule Watchnature.Repo.Migrations.AddLocationDataToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :location_common_name, :string
      add :location, :geometry
    end
  end
end
