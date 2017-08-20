defmodule WatchnatureWeb.PostController do
  use WatchnatureWeb, :controller

  alias Watchnature.{Stream, Post, ErrorView}

  action_fallback WatchnatureWeb.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, [handler: WatchnatureWeb.AuthController] when action in [:create, :update, :delete]
  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, params) do
    with :ok <- Bodyguard.permit(Stream, :paginate_posts, conn) do
      page = Stream.paginate_posts(params)
      render(conn, "index.json", posts: page.entries, page: page)
    end
  end

  def create(conn, %{"post" => post_params}) do
    {:ok, user_id} = Map.fetch(conn.assigns[:current_user], :id)
    post_params = Map.put_new(post_params, "user_id", user_id)

    with :ok <- Bodyguard.permit(Stream, :create_post, user_id) do
      with {:ok, post} <- Stream.create_post(post_params) do
        conn
        |> put_status(:created)
        |> render("show.json", post: post)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    post = Stream.get_post!(id)

    with :ok <- Bodyguard.permit(Stream, :get_post, conn, post: post) do
      render(conn, "show.json", post: post)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Stream.get_post!(id)

    with :ok <- Bodyguard.permit(Stream, :update_post, conn, post) do
      with {:ok, post} <- Stream.update_post(post, post_params),
       do: render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => post_id}) do
    current_user = conn.assigns.current_user

    with :ok <- Bodyguard.permit(Stream, :delete_post, current_user.id) do
      post = Stream.get_post!(post_id)
      with {:ok, conn} <- Stream.delete_post(post),
       do: send_resp(conn, :no_content, "")
    end
  end
end
