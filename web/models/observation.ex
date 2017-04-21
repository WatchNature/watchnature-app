defmodule Watchnature.Observation do
  use Watchnature.Web, :model

  schema "observations" do
    field :description, :string
    field :location_name, :string
    field :location, Geo.Point

    belongs_to :user, Watchnature.User
    belongs_to :post, Watchnature.Post

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :location_name, :location, :user_id, :post_id])
    |> validate_required([:description, :user_id, :post_id])
  end

  # If location map is empty (nothing sent by client) then remove
  # that map from the params altogether as Geo will throw when it
  # tries to parse an empty coordinates array
  defp remove_location_if_empty(%{"location" => %{"coordinates" => [], "type" => "Point"}} = params) do
    Map.delete(params, "location")
  end
  defp remove_location_if_empty(params), do: params
end
