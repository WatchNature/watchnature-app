defmodule WatchnatureWeb.PostView do
  use WatchnatureWeb, :view

  def render("index.json", %{posts: posts, page: page}) do
    meta = %{
      page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages
    }

    %{data: render_many(posts, WatchnatureWeb.PostView, "post.json"), meta: meta}
  end
  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, WatchnatureWeb.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, WatchnatureWeb.PostView, "post.json")}
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
      user: render_one(post.user, WatchnatureWeb.UserView, "user.json"),
      observations: render_many(post.observations,  WatchnatureWeb.ObservationView, "observation.json")}
  end
end
