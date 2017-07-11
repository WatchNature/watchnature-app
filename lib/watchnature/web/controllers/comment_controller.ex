defmodule Watchnature.Web.CommentController do
  use Watchnature.Web, :controller

  alias Watchnature.{Comment, ErrorView}

  plug Guardian.Plug.EnsureAuthenticated, [handler: Watchnature.AuthController] when action in [:create, :update, :delete]
  plug :scrub_params, "comment" when action in [:create, :update]

  # def index(conn, %{"post_id" => post_id}) do
  #   comments = Repo.all(from c in Comment, where: c.post_id == ^post_id)

  #   render(conn, "index.json", comments: comments)
  # end

  # def create(conn, %{"post_id" => post_id, "comment" => comment_params}) do
  #   {:ok, user_id} = Map.fetch(conn.assigns[:current_user], :id)
  #   comment_params = comment_params
  #   |> Map.put_new("user_id", user_id)
  #   |> Map.put_new("post_id", post_id)

  #   changeset = Comment.changeset(%Comment{}, comment_params)

  #   case Repo.insert(changeset) do
  #     {:ok, comment} ->
  #       conn
  #       |> put_status(:created)
  #       |> put_resp_header("location", post_comment_path(conn, :show, post_id, comment))
  #       |> render("show.json", comment: comment)
  #     {:error, changeset} ->
  #       conn
  #       |> put_status(:unprocessable_entity)
  #       |> render(Watchnature.Web.ChangesetView, "error.json", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   comment = Repo.get!(Comment, id)
  #   render(conn, "show.json", comment: comment)
  # end

  # def update(conn, %{"id" => id, "comment" => comment_params}) do
  #   comment = Repo.get!(Comment, id)
  #   changeset = Comment.body_changeset(comment, comment_params)

  #   case authorize(conn, comment) do
  #     {:ok, conn} ->
  #       case Repo.update(changeset) do
  #         {:ok, comment} ->
  #           render(conn, "show.json", comment: comment)
  #         {:error, changeset} ->
  #           conn
  #           |> put_status(:unprocessable_entity)
  #           |> render(Watchnature.Web.ChangesetView, "error.json", changeset: changeset)
  #       end
  #     {:error, _} ->
  #       conn
  #       |> put_status(:forbidden)
  #       |> render(Watchnature.Web.ErrorView, "403.json")
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   comment = Repo.get!(Comment, id)

  #   case authorize(conn, comment) do
  #     {:ok, conn} ->
  #       # Here we use delete! (with a bang) because we expect
  #       # it to always work (and if it does not, it will raise).
  #       Repo.delete!(comment)
  #       send_resp(conn, :no_content, "")
  #     {:error, _} ->
  #       conn
  #       |> put_status(:forbidden)
  #       |> render(Watchnature.Web.ErrorView, "403.json")
  #   end
  # end
end
