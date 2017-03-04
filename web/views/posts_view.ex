defmodule Watchnature.PostsView do
  use Watchnature.Web, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, Watchnature.PostsView, "posts.json")}
  end

  def render("show.json", %{posts: posts}) do
    %{data: render_one(posts, Watchnature.PostsView, "posts.json")}
  end

  def render("posts.json", %{posts: posts}) do
    %{id: posts.id,
      description: posts.description,
      user_id: posts.user_id}
  end
end
