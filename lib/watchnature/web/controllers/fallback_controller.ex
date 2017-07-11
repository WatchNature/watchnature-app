defmodule Watchnature.Web.FallbackController do
  use Watchnature.Web, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(Watchnature.Web.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(Watchnature.Web.ErrorView, "401.json")
  end
end
