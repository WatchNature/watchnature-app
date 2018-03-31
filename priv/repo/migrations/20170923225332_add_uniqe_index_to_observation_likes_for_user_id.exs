defmodule Watchnature.Repo.Migrations.AddUniqeIndexToObservationLikesForUserId do
  use Ecto.Migration

  def change do
    create unique_index(:observation_likes, [:user_id, :observation_id])
  end
end
