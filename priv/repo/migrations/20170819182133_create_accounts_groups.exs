defmodule Watchnature.Repo.Migrations.CreateAccountsGroups do
  use Ecto.Migration

  def change do
    create table(:accounts_groups) do
      add :name, :string

      timestamps()
    end

  end
end
