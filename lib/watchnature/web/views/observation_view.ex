defmodule Watchnature.Web.ObservationView do
  use Watchnature.Web, :view

  def render("index.json", %{observations: observations}) do
    %{data: render_many(observations, Watchnature.Web.ObservationView, "observation.json")}
  end

  def render("show.json", %{observation: observation}) do
    %{data: render_one(observation, Watchnature.Web.ObservationView, "observation.json")}
  end

  def render("observation.json", %{observation: observation}) do
    %{id: observation.id,
      description: observation.description,
      user_id: observation.user_id,
      post_id: observation.post_id,
      location_name: observation.location_name}
  end
end
