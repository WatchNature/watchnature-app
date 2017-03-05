defmodule Watchnature.Post do
  use Watchnature.Web, :model

  schema "posts" do
    field :description, :string
    belongs_to :user, Watchnature.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :user_id])
    |> validate_required([:description])
    |> foreign_key_constraint(:user_id)
  end

  def sorted(query \\ __MODULE__) do
    from p in query,
    order_by: [desc: p.inserted_at]
  end
end
