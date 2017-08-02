defmodule WatchnatureWeb.FallbackController do
  use WatchnatureWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(WatchnatureWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(WatchnatureWeb.ErrorView, "401.json")
  end
end
