defmodule Watchnature.Repo.Migrations.RenameUsersToAccountsUsers do
  use Ecto.Migration

  def change do
    rename table(:users), to: table(:accounts_users)
  end
end
