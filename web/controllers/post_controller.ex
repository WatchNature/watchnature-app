defmodule Watchnature.PostController do
  use Watchnature.Web, :controller

  alias Watchnature.Post

  plug Guardian.Plug.EnsureAuthenticated, [handler: Watchnature.AuthController] when action in [:create, :update, :delete]
  plug :scrub_params, "post" when action in [:create, :update]

  def index(conn, _params) do
    posts = Post
    |> Post.sorted
    |> Repo.all
    |> Repo.preload(:user)

    render(conn, "index.json", posts: posts)
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
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        render(conn, "show.json", post: post)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Watchnature.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    send_resp(conn, :no_content, "")
  end
end
