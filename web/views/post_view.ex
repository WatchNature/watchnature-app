defmodule Watchnature.PostView do
  use Watchnature.Web, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, Watchnature.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, Watchnature.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      description: post.description,
      user: render_one(post.user, Watchnature.UserView, "user.json")}
  end
end
