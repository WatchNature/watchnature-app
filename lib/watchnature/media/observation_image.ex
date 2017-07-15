defmodule Watchnature.Media.ObservationImage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Watchnature.Media.ObservationImage


  schema "observation_images" do
    field :public_id, :string
    field :secure_url, :string
    field :url, :string

    belongs_to :observation, Watchnature.Stream.Observation

    timestamps()
  end

  @doc false
  def changeset(%ObservationImage{} = observation_image, attrs) do
    observation_image
    |> cast(attrs, [:public_id, :url, :secure_url, :observation_id])
    |> validate_required([:public_id, :url, :secure_url, :observation_id])
  end
end
