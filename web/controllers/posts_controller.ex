defmodule Watchnature.PostsController do
  use Watchnature.Web, :controller

  alias Watchnature.Posts

  def index(conn, _params) do
    posts = Repo.all(Posts)
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"posts" => posts_params}) do
    changeset = Posts.changeset(%Posts{}, posts_params)

    case Repo.insert(changeset) do
      {:ok, posts} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", posts_path(conn, :show, posts))
        |> render("show.json", posts: posts)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Watchnature.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    posts = Repo.get!(Posts, id)
    render(conn, "show.json", posts: posts)
  end

  def update(conn, %{"id" => id, "posts" => posts_params}) do
    posts = Repo.get!(Posts, id)
    changeset = Posts.changeset(posts, posts_params)

    case Repo.update(changeset) do
      {:ok, posts} ->
        render(conn, "show.json", posts: posts)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Watchnature.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    posts = Repo.get!(Posts, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(posts)

    send_resp(conn, :no_content, "")
  end
end
