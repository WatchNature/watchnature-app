defmodule Watchnature.Repo.Migrations.CreateObservationLikes do
  use Ecto.Migration

  def change do
    create table(:observation_likes) do
      add :observation_id, references(:observations, on_delete: :delete_all)
      add :user_id, references(:accounts_users, on_delete: :delete_all)

      timestamps()
    end

    create index(:observation_likes, [:observation_id])
    create index(:observation_likes, [:user_id])
  end
end
