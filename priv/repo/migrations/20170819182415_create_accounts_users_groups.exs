defmodule Watchnature.Repo.Migrations.CreateAccountsUsersGroups do
  use Ecto.Migration

  def change do
    create table(:accounts_users_groups) do
      add :user_id, references(:users, on_delete: :nothing)
      add :group_id, references(:accounts_groups, on_delete: :nothing)

      timestamps()
    end

    create index(:accounts_users_groups, [:user_id])
    create index(:accounts_users_groups, [:group_id])
  end
end
