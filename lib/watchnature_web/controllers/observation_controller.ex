defmodule WatchnatureWeb.ObservationController do
  use WatchnatureWeb, :controller

  alias Watchnature.{Stream, Stream.Observation, Stream.Post, ErrorView}

  plug Guardian.Plug.EnsureAuthenticated, [handler: WatchnatureWeb.AuthController] when action in [:create, :update, :delete]
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
        |> render(WatchnatureWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    observation = Repo.get!(Observation, id)
    render(conn, "show.json", observation: observation)
  end

  def update(conn, %{"id" => id, "observation" => observation_params}) do
    {:ok, user_id} = Map.fetch(conn.assigns[:current_user], :id)
    observation = Repo.get!(Observation, id) |> Repo.preload([:tags])
    changeset = Observation.changeset(observation, observation_params)

    with :ok <- Bodyguard.permit(Stream, :update_observation, user_id) do
      case Repo.update(changeset) do
        {:ok, observation} ->
          render(conn, "show.json", observation: observation)
        {:error, changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(WatchnatureWeb.ChangesetView, "error.json", changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    {:ok, user_id} = Map.fetch(conn.assigns[:current_user], :id)
    observation = Repo.get!(Observation, id)

    with :ok <- Bodyguard.permit(Stream, :delete_observation, user_id) do
      Repo.delete!(observation)
      send_resp(conn, :no_content, "")
    end
  end

  defp authorize_post!(%{params: %{"post_id" => post_id}} = conn, _) do
    {:ok, user_id} = Map.fetch(conn.assigns[:current_user], :id)
    post = Repo.get!(Post, post_id)

    with :ok <- Bodyguard.permit(Stream, :update_post, user_id) do
      conn
    end
  end
end
