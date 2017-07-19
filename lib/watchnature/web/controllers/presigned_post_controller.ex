defmodule Watchnature.Web.PresignedPostController do
  use Watchnature.Web, :controller

  alias Watchnature.Media

  action_fallback Watchnature.Web.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, [handler: Watchnature.AuthController] when action in [:presign]

  def presign(conn, _) do
    {:ok, url} = Media.create_presigned_post_url()
    render(conn, "presign.json", url: url)
  end
end
