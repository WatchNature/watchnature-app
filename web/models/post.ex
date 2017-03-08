defmodule Watchnature.Post do
  use Watchnature.Web, :model

  schema "posts" do
    field :description, :string
    field :location, Geo.Point
    field :location_name, :string

    belongs_to :user, Watchnature.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    params = remove_location_if_empty(params)

    struct
    |> cast(params, [:description, :location, :location_name, :user_id])
    |> validate_required([:description])
    |> foreign_key_constraint(:user_id)
  end

  def sorted(query \\ __MODULE__) do
    from p in query,
    order_by: [desc: p.inserted_at]
  end

  # If location map is empty (nothing sent by client) then remove
  # that map from the prams altogehter as Geo will throw when it
  # tries to parse an empty coordinates array
  defp remove_location_if_empty(params) do
    case params do
      %{"location" => %{"coordinates" => [], "type" => "Point"}} -> Map.delete(params, "location")
      _ -> params
    end
  end
end
