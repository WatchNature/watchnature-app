defmodule Watchnature.Reactions.Stat do
  @moduledoc """
  A struct that contains statistics for reactions on a given resource
  """

  defstruct likes: 0

  import Ecto.Query

  alias Watchnature.Repo
  alias Watchnature.Reactions.Stat
  alias Watchnature.Reactions.ObservationLike

  def from_observation(observation) do
    count = from(ol in ObservationLike,
      where: ol.observation_id == ^observation.id,
      select: count(ol.id))
    |> Repo.one()

    %Stat{likes: count}
  end
end
