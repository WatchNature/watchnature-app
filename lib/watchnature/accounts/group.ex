defmodule Watchnature.Accounts.Group do
  use Ecto.Schema
  import Ecto.Changeset
  alias Watchnature.Accounts.Group


  schema "accounts_groups" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
