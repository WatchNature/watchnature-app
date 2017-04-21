defmodule Watchnature.PostController do
  use Watchnature.Web, :controller

  alias Watchnature.{Post, ErrorView}

  plug Guardian.Plug.EnsureAuthenticated, [handler: Watchnature.AuthController] when action in [:create, :update, :delete]
  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, _params) do
    case authorize(conn, Post) do
      {:ok, conn} ->
        posts = Post
        |> Post.sorted
        |> Repo.all
        |> Repo.preload(:user)

        render(conn, "index.json", posts: posts)
      {:error, _} ->
        render(conn, ErrorView, "403.json")
    end
  end

  def create(conn, %{"post" => post_params}) do
    {:ok, user_id} = Map.fetch(conn.assigns[:current_user], :id)
    post_params = Map.put_new(post_params, "user_id", user_id)
    changeset = Post.changeset(%Post{}, post_params)

    case Repo.insert(changeset) do
      {:ok, post} ->
        post = Repo.preload(post, :user)

        conn
        |> put_status(:created)
        |> put_resp_header("location", post_path(conn, :show, post))
        |> render("show.json", post: post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Watchnature.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id) |> Repo.preload(:user)

    case authorize(conn, post) do
      {:ok, conn} -> render(conn, "show.json", post: post)
      {:error, _} -> render(conn, ErrorView, "403.json")
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case authorize(conn, post) do
      {:ok, conn} ->
        case Repo.update(changeset) do
          {:ok, post} ->
            post = Repo.preload(post, :user)
            render(conn, "show.json", post: post)
          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(Watchnature.ChangesetView, "error.json", changeset: changeset)
        end
      {:error, _} ->
        render(conn, ErrorView, "403.json")
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    case authorize(conn, post) do
      {:ok, conn} ->
        Repo.delete!(post)
        send_resp(conn, :no_content, "")
      {:error, _} ->
        render(conn, ErrorView, "403.json")
    end
  end
end
