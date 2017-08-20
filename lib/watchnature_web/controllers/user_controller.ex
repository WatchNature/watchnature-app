defmodule WatchnatureWeb.UserController do
  use WatchnatureWeb, :controller

  alias Watchnature.Accounts
  alias Watchnature.Accounts.User

  plug Guardian.Plug.EnsureAuthenticated, [handler: WatchnatureWeb.AuthController] when action in [:update, :delete]
  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(WatchnatureWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    current_user = conn.assigns.current_user

    with :ok <- Bodyguard.permit(Accounts, :get_user, current_user.id, id) do
      user = Accounts.get_user!(id)
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => user_id, "user" => user_params}) do
    current_user = conn.assigns.current_user

    with :ok <- Bodyguard.permit(Accounts, :update_user, current_user.id, user_id) do
      case Accounts.update_user(current_user, user_params) do
        {:ok, user} -> render(conn, "show.json", user: user)
      end
    end
  end

  def delete(conn, %{"id" => user_id}) do
    current_user = conn.assigns.current_user

    with :ok <- Bodyguard.permit(Accounts, :delete_user, current_user.id, user_id) do
      user = Accounts.get_user!(user_id)
      Accounts.delete_user(user)

      send_resp(conn, :no_content, "")
    end
  end
end
