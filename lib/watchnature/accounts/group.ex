defmodule Watchnature.Accounts.Group do
  use Ecto.Schema
  import Ecto.Changeset

  alias Watchnature.Accounts
  alias Watchnature.Accounts.Group

  schema "accounts_groups" do
    field :name, :string

    many_to_many :users, Accounts.User, join_through: Watchnature.Accounts.UserGroup, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
