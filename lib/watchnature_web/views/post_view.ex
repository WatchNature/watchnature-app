defmodule WatchnatureWeb.PostView do
  use WatchnatureWeb, :view

  alias __MODULE__
  alias WatchnatureWeb.{UserView, ObservationView}

  def render("index.json", %{posts: posts, page: page, user: requesting_user}), do:
    %{data: render_many(posts, PostView, "post.json", user: requesting_user), meta: meta_data(page)}

  def render("index.json", %{posts: posts, page: page}), do:
    %{data: render_many(posts, PostView, "post.json"), meta: meta_data(page)}

  def render("index.json", %{posts: posts}), do:
    %{data: render_many(posts, PostView, "post.json")}

  def render("show.json", %{post: post, user: requesting_user}), do:
    %{data: render_one(post, PostView, "post.json", user: requesting_user)}

  def render("show.json", %{post: post}), do:
    %{data: render_one(post, PostView, "post.json")}

  def render("post.json", %{post: post, user: requesting_user}) do
    post
    |> post_data(requesting_user)
    |> Map.put_new(:current_user, %{})
  end

  def render("post.json", %{post: post}) do
    post
    |> post_data
  end

  defp post_data(post, requesting_user \\ nil) do
    %{id: post.id,
      inserted_at: post.inserted_at,
      description: post.description,
      location_name: post.location_name,
      location: post_location(post.location),
      user: render_one(post.user, WatchnatureWeb.UserView, "user.json"),
      observations: post_observations(post, requesting_user)}
  end

  defp post_observations(post, nil), do:
    render_many(post.observations, ObservationView, "observation.json")

  defp post_observations(post, requesting_user), do:
    render_many(post.observations, ObservationView, "observation.json", user: requesting_user)

  defp meta_data(page) do
    %{page_number: page.page_number,
      page_size: page.page_size,
      total_entries: page.total_entries,
      total_pages: page.total_pages}
  end

  defp post_location(%Geo.Point{coordinates: {lat, lng}}), do: %{lat: lat, lng: lng}
  defp post_location(nil), do: %{lat: nil, lng: nil}
end
