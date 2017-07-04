defmodule Watchnature.Web.PostView do
  use Watchnature.Web, :view
  require IEx

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, Watchnature.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, Watchnature.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    location = case post.location do
      %Geo.Point{coordinates: {lat, lng}} -> %{lat: lat, lng: lng}
      nil -> %{lat: nil, lng: nil}
    end

    %{id: post.id,
      inserted_at: post.inserted_at,
      description: post.description,
      location_name: post.location_name,
      location: location,
      user: render_one(post.user, Watchnature.UserView, "user.json"),
      observations: render_many(post.observations, Watchnature.ObservationView, "observation.json")}
  end
end
