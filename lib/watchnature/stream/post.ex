defmodule Watchnature.Stream.Post do
  use WatchnatureWeb, :model

  alias Watchnature.{Stream.Observation, Comment}
  alias Watchnature.Accounts

  schema "posts" do
    field :description, :string
    field :location, Geo.Point
    field :location_name, :string

    belongs_to :user, Accounts.User

    has_many :observations, Observation, on_delete: :delete_all
    has_many :comments, Comment

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    params = remove_location_if_empty(params)

    struct
    |> cast(params, [:description, :location, :location_name, :user_id])
    |> validate_required([])
    |> foreign_key_constraint(:user_id)
    |> cast_assoc(:observations)
  end

  @doc false
  def sorted(query \\ __MODULE__) do
    from p in query,
    order_by: [desc: p.inserted_at]
  end

  # If location map is empty (nothing sent by client) then remove
  # that map from the params altogether as Geo will throw when it
  # tries to parse an empty coordinates array
  defp remove_location_if_empty(
    %{"location" => %{"coordinates" => [], "type" => "Point"}} = params
  ) do
    Map.delete(params, "location")
  end
  defp remove_location_if_empty(params), do: params
end
