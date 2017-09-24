defmodule Watchnature.Reactions.Stat do
  @moduledoc """
  A struct that contains statistics for reactions on a given resource
  """

  defstruct likes: 0, recent_likers: []

  import Ecto.Query

  alias Watchnature.Repo
  alias Watchnature.Reactions.Stat
  alias Watchnature.Reactions.ObservationLike

  def from_observation(observation) do

    %Stat{
      likes: likes_count(observation.id),
      recent_likers: recent_likers(observation.id)
    }
  end

  defp likes_count(observation_id) do
    from(ol in ObservationLike,
      where: ol.observation_id == ^observation_id,
      select: count(ol.id))
    |> Repo.one()
  end

  defp recent_likers(observation_id, limit \\ 1) do
    from(ol in ObservationLike,
      where: ol.observation_id == ^observation_id,
      join: u in assoc(ol, :user),
      order_by: [desc: ol.inserted_at],
      select: %{email: u.email, first_name: u.first_name, last_name: u.last_name},
      limit: ^limit)
    |> Repo.all()
  end
end
