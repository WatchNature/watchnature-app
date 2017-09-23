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
    |> unique_constraint(:user, name: :observation_likes_user_id_observation_id_index)
    |> put_assoc(:observation, attrs.observation)
    |> assoc_constraint(:observation)
    |> unique_constraint(:observation, name: :observation_likes_user_id_observation_id_index)
  end
end
