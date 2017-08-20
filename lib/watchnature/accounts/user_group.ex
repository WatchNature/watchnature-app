defmodule Watchnature.Accounts.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  alias Watchnature.Accounts
  alias Watchnature.Accounts.UserGroup


  schema "accounts_users_groups" do
    belongs_to :user, Accounts.User
    belongs_to :group, Accounts.Group

    timestamps()
  end

  @doc false
  def changeset(%UserGroup{} = user_group, attrs) do
    user_group
    |> cast(attrs, [:user_id, :group_id])
    |> validate_required([])
  end
end
