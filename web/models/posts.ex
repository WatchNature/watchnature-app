defmodule Watchnature.Posts do
  use Watchnature.Web, :model

  schema "posts" do
    field :description, :string
    belongs_to :user, Watchnature.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description])
    |> validate_required([:description])
  end
end
