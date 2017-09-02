defmodule Watchnature.Reactions.ObservationLike do
  use Ecto.Schema
  import Ecto.Changeset
  alias Watchnature.Reactions.ObservationLike

  schema "observation_likes" do
    belongs_to :observation, Watchnature.Stream.Observation
    belongs_to :user, Watchnature.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%ObservationLike{} = observation_like, attrs) do
    observation_like
    |> cast(attrs, [:observation_id, :user_id])
    |> validate_required([])
    |> put_assoc(:user, attrs.user)
    |> assoc_constraint(:user)
    |> put_assoc(:observation, attrs.observation)
    |> assoc_constraint(:observation)
  end
end
