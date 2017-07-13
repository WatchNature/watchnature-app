defmodule Watchnature.Comment do
  use Watchnature.Web, :model

  alias Watchnature.{Stream.Post, User}

  schema "comments" do
    field :body, :string
    field :flagged, :boolean, default: false

    belongs_to :post, Post
    belongs_to :user, User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :user_id, :post_id, :flagged])
    |> validate_required([:body, :user_id, :post_id])
  end

  def body_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :flagged])
    |> validate_required([:body, :flagged])
  end
end
