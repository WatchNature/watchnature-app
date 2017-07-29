defmodule Watchnature.Stream.Observation do
  use Watchnature.Web, :model

  alias Watchnature.{Stream.Observation, Tag, ObservationTag, User, Stream.Post, Repo}

  schema "observations" do
    field :description, :string
    field :location_name, :string
    field :location, Geo.Point

    belongs_to :post, Post

    has_many :images, Watchnature.Media.ObservationImage

    many_to_many :tags, Tag, join_through: ObservationTag,  on_replace: :delete

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    params = remove_location_if_empty(params)

    struct
    |> cast(params, [:description, :location_name, :location])
    |> validate_required([:description])
    |> cast_assoc(:images)
    |> put_assoc(:tags, parse_and_get_tags(params))
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

  @doc """
  Extracts Tag ids from params and returns a list of structs
  """
  defp parse_and_get_tags(params) do
    ids = params["tags"] || []
    Repo.all(from t in Tag, where: t.id in ^ids)
  end
end
