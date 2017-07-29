defmodule Watchnature.Web.MediaController do
  use Watchnature.Web, :controller

  alias Watchnature.Media

  action_fallback Watchnature.Web.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, [handler: Watchnature.AuthController] when action in [:create]

  def create(conn, %{"file" => file}) do
    with {:ok, file} <- Media.upload_attachment(file) do
      path = Media.get_attachment_url(file)
      send_resp(conn, :ok, Poison.encode!(%{url: path}))
    end
  end
end
