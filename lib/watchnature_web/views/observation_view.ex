defmodule WatchnatureWeb.ObservationView do
  use WatchnatureWeb, :view

  def render("index.json", %{observations: observations}) do
    %{data: render_many(observations, WatchnatureWeb.ObservationView, "observation.json")}
  end

  def render("show.json", %{observation: observation}) do
    %{data: render_one(observation, WatchnatureWeb.ObservationView, "observation.json")}
  end

  def render("observation.json", %{observation: observation}) do
    location = case observation.location do
      %Geo.Point{coordinates: {lat, lng}} -> %{lat: lat, lng: lng}
      nil -> %{lat: nil, lng: nil}
    end

    %{id: observation.id,
      description: observation.description,
      post_id: observation.post_id,
      location_name: observation.location_name,
      location: location,
      images: render_many(observation.images, WatchnatureWeb.Observation.ObservationImageView, "observation_image.json"),
      species: render_one(observation.species, WatchnatureWeb.SpeciesView, "species.json")}
  end
end
