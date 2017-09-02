defmodule Watchnature.Reactions do
  @moduledoc """
  The Reactions context.
  """

  import Ecto.Query, warn: false
  alias Watchnature.Repo

  alias Watchnature.Stream
  alias Watchnature.Accounts
  alias Watchnature.Reactions.ObservationLike

  defdelegate authorize(action, user, params), to: Watchnature.Reactions.Policy

  @doc """
  Returns a like between the given user and entity.
  """
  def get_like(%Accounts.User{} = user, %Stream.Observation{} = observation) do
    query = from ol in ObservationLike,
              where: ol.user_id == ^user.id and ol.observation_id == ^observation.id

    Repo.one(query)
  end

  @doc """
  Creates a like between the given user and entity.

  ## Examples

      iex>add_like(%User{}, %Observation{})
      %ObservationLike{}

  """
  def add_like(%Accounts.User{} = user, %Stream.Observation{} = observation),
    do: create_observation_like(%{user: user, observation: observation})

  @doc """
  Deletes the given ObservationLike
  """
  def delete_like(%ObservationLike{} = observation_like),
    do: delete_observation_like(observation_like)

  defp create_observation_like(attrs \\ %{}) do
    %ObservationLike{}
    |> ObservationLike.changeset(attrs)
    |> Repo.insert()
  end

  defp delete_observation_like(%ObservationLike{} = observation_like) do
    Repo.delete(observation_like)
  end
end
