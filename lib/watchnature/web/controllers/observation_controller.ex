defmodule Watchnature.Web.ObservationController do
  use Watchnature.Web, :controller

  alias Watchnature.{Observation, Post, ErrorView}

  plug Guardian.Plug.EnsureAuthenticated, [handler: Watchnature.AuthController] when action in [:create, :update, :delete]
  plug :scrub_params, "observation" when action in [:create, :update]
  plug :authorize_post! when action in [:create, :update]

  def index(conn, %{"post_id" => post_id}) do
    observations = Repo.all(from o in Observation, where: o.post_id == ^post_id)
    render(conn, "index.json", observations: observations)
  end

  def create(conn, %{"post_id" => post_id, "observation" => observation_params}) do
    {:ok, user_id} = Map.fetch(conn.assigns[:current_user], :id)
    observation_params = observation_params
    |> Map.put_new("user_id", user_id)
    |> Map.put_new("post_id", post_id)

    changeset = Observation.changeset(%Observation{}, observation_params)

    case Repo.insert(changeset) do
      {:ok, observation} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", post_observation_path(conn, :show, post_id, observation))
        |> render("show.json", observation: observation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Watchnature.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    observation = Repo.get!(Observation, id)
    render(conn, "show.json", observation: observation)
  end

  def update(conn, %{"id" => id, "observation" => observation_params}) do
    observation = Repo.get!(Observation, id) |> Repo.preload([:tags])
    changeset = Observation.changeset(observation, observation_params)

    case authorize(conn, observation) do
      {:ok, conn} ->
        case Repo.update(changeset) do
          {:ok, observation} ->
            render(conn, "show.json", observation: observation)
          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render(Watchnature.Web.ChangesetView, "error.json", changeset: changeset)
        end
      {:error, _} ->
        conn
        |> put_status(:forbidden)
        |> render(Watchnature.Web.ErrorView, "403.json")
    end
  end

  def delete(conn, %{"id" => id}) do
    observation = Repo.get!(Observation, id)

    case authorize(conn, observation) do
      {:ok, conn} ->
        # Here we use delete! (with a bang) because we expect
        # it to always work (and if it does not, it will raise).
        Repo.delete!(observation)
        send_resp(conn, :no_content, "")
      {:error, _} ->
        conn
        |> put_status(:forbidden)
        |> render(Watchnature.Web.ErrorView, "403.json")
    end
  end

  defp authorize_post!(%{params: %{"post_id" => post_id}} = conn, _) do
    post = Repo.get!(Post, post_id)

    case authorize(conn, post) do
      {:ok, conn} -> conn
      {:error, _} ->
        conn
        |> put_status(:forbidden)
        |> render(Watchnature.Web.ErrorView, "403.json")
        |> halt()
    end
  end
end
