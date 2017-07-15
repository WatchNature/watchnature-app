defmodule Watchnature.Repo.Migrations.CreateWatchnature.Media.ObservationImage do
  use Ecto.Migration

  def change do
    create table(:observation_images) do
      add :public_id, :string
      add :url, :string
      add :secure_url, :string
      add :observation_id, references(:observations, on_delete: :delete_all)

      timestamps()
    end

  end
end
