defmodule WatchnatureWeb.PresignedPostView do
  use WatchnatureWeb, :view

  def render("presign.json", %{url: url}) do
    %{data: render_one(url, WatchnatureWeb.PresignedPostView, "presigned_post.json", %{url: url})}
  end

  def render("presigned_post.json", %{url: url}) do
    %{url: url}
  end
end
