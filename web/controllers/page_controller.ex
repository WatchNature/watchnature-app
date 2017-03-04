defmodule Watchnature.PageController do
  use Watchnature.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
