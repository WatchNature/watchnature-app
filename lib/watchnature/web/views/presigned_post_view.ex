defmodule Watchnature.Web.PresignedPostView do
  use Watchnature.Web, :view

  def render("presign.json", %{url: url}) do
    %{data: render_one(url, Watchnature.Web.PresignedPostView, "presigned_post.json", %{url: url})}
  end

  def render("presigned_post.json", %{url: url}) do
    %{url: url}
  end
end
