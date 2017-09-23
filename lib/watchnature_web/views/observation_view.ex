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

    data = %{id: observation.id,
      inserted_at: observation.inserted_at,
      description: observation.description,
      post_id: observation.post_id,
      location_name: observation.location_name,
      location: location,
      images: render_many(observation.images, WatchnatureWeb.Observation.ObservationImageView, "observation_image.json"),
      species: render_one(observation.species, WatchnatureWeb.SpeciesView, "species.json"),

      current_user: %{
        like_id: nil
      },

      reactions: Watchnature.Reactions.get_stats(observation)
    }


    case observation.likes do
      %Ecto.Association.NotLoaded{} -> data
      [] -> data
      likes ->
        data
        |> Map.put(:current_user, %{like_id: List.first(likes).id})
        |> Map.put(:likes_count, Enum.count(likes))
    end
  end
end
