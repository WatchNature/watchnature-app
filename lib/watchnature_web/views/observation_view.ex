defmodule WatchnatureWeb.ObservationView do
  use WatchnatureWeb, :view

  alias __MODULE__
  alias Watchnature.Reactions
  alias WatchnatureWeb.{Observation.ObservationImageView, Observation.ObservationLikeView, SpeciesView}

  def render("index.json", %{observations: observations}) do
    %{data: render_many(observations, ObservationView, "observation.json")}
  end

  def render("show.json", %{observation: observation}) do
    %{data: render_one(observation, ObservationView, "observation.json")}
  end

  def render("observation.json", %{observation: observation, user: requesting_user}) do

    observation
    |> observation_data()
    |> Map.put_new(:reactions, Reactions.get_stats(observation))
    |> Map.put_new(:current_user, %{})
    |> put_in([:current_user, :like], observation_like_data(observation, requesting_user))
  end

  def render("observation.json", %{observation: observation}) do
    observation
    |> observation_data()
    |> Map.put_new(:reactions, Reactions.get_stats(observation))
  end

  defp observation_like_data(observation, user) do
    observation_like = Reactions.get_like(user, observation)
    render_one(observation_like, ObservationLikeView, "observation_like.json")
  end

  defp observation_data(observation) do
    %{id: observation.id,
      inserted_at: observation.inserted_at,
      description: observation.description,
      post_id: observation.post_id,
      location_name: observation.location_name,
      location: observation_location(observation.location),
      images: render_many(observation.images, ObservationImageView, "observation_image.json"),
      species: render_one(observation.species, SpeciesView, "species.json")}
  end

  defp observation_location(%Geo.Point{coordinates: {lat, lng}}), do: %{lat: lat, lng: lng}
  defp observation_location(nil), do: %{lat: nil, lng: nil}
end
