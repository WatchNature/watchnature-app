defmodule Watchnature.Media.ObservationImage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Watchnature.Media.ObservationImage


  schema "observation_images" do
    # TODO: Remove public_id and secure_url
    field :public_id, :string
    field :secure_url, :string
    field :url, :string

    belongs_to :observation, Watchnature.Stream.Observation

    timestamps()
  end

  @doc false
  def changeset(%ObservationImage{} = observation_image, attrs) do
    observation_image
    |> cast(attrs, [:observation_id, :url])
  end
end
