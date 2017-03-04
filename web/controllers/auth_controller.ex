defmodule Watchnature.AuthController do
  use Watchnature.Web, :controller

  alias Watchnature.{ErrorView, UserView, User, AuthController}

  plug Ueberauth
  plug Guardian.Plug.EnsureAuthenticated, [handler: AuthController] when action in [:delete, :me]

  def indentity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    result = with {:ok, user} <- user_from_auth(auth),
                  :ok <- validate_pass(user.password_hash, auth.credentials.other.password),
                  do: signin_user(conn, user)

    case result do
      {:ok, user, token} ->
        conn
        |> put_status(:created)
        |> render(UserView, "authenticated.json", user: user, token: token)
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> render(ErrorView, "error.json", data: reason)
    end
  end

  def me(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, UserView, "show.json", user: user)
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> render(ErrorView, "error.json-api", data: %{error: %{title: "Authentication Required", status: 401}})
  end

  def unauthorized(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> render(ErrorView, "error.json-api", data: %{error: %{title: "Unauthorized", status: 401}})
  end

  defp user_from_auth(auth) do
    result = Repo.get_by(User, email: auth.info.email)

    case result do
      nil -> {:error, %{error: %{title: "Invalid email or password", status: 422}}}
      user -> {:ok, user}
    end
  end

  defp validate_pass(_encrypted, password) when password in [nil, ""] do
    {:error, %{error: %{title: "Password is required", status: 422}}}
  end

  defp validate_pass(encrypted, password) do
    if Comeonin.Bcrypt.checkpw(password, encrypted) do
      :ok
    else
      {:error, %{error: %{title: "Invalid email or password", status: 422}}}
    end
  end

  defp signin_user(conn, user) do
    token = conn
            |> Guardian.Plug.api_sign_in(user)
            |> Guardian.Plug.current_token
    {:ok, user, token}
  end
end
