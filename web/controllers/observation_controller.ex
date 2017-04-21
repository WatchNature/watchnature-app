defmodule Watchnature.ObservationController do
  use Watchnature.Web, :controller

  alias Watchnature.Observation

  plug Guardian.Plug.EnsureAuthenticated, [handler: Watchnature.AuthController] when action in [:create, :update, :delete]
  plug :scrub_params, "observation" when action in [:create, :update]

  def index(conn, _params) do
    observations = Repo.all(Observation)
    render(conn, "index.json", observations: observations)
  end

  def create(conn, %{"observation" => observation_params}) do
    changeset = Observation.changeset(%Observation{}, observation_params)

    case Repo.insert(changeset) do
      {:ok, observation} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", observation_path(conn, :show, observation))
        |> render("show.json", observation: observation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Watchnature.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    observation = Repo.get!(Observation, id)
    render(conn, "show.json", observation: observation)
  end

  def update(conn, %{"id" => id, "observation" => observation_params}) do
    observation = Repo.get!(Observation, id)
    changeset = Observation.changeset(observation, observation_params)

    case Repo.update(changeset) do
      {:ok, observation} ->
        render(conn, "show.json", observation: observation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Watchnature.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    observation = Repo.get!(Observation, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(observation)

    send_resp(conn, :no_content, "")
  end
end
