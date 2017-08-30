defmodule WatchnatureWeb.Observation.ObservationLikeController do
  use WatchnatureWeb, :controller

  alias Watchnature.Stream
  alias Watchnature.Reactions

  action_fallback WatchnatureWeb.FallbackController

  plug Guardian.Plug.EnsureAuthenticated, [handler: WatchnatureWeb.AuthController] when action in [:create, :delete]

  def create(conn, %{"observation_id" => observation_id} = params) do
    user = Guardian.Plug.current_resource(conn)
    observation = Stream.get_observation!(observation_id)

    with :ok <- Bodyguard.permit(Reactions, :add_like, user.id),
         {:ok, observation_like} <- Reactions.add_like(user, observation)
    do
      conn
      |> put_status(:created)
      |> render("show.json", observation_like: observation_like)
    end
  end

  def delete(conn, %{"observation_id" => observation_id}) do
    user = Guardian.Plug.current_resource(conn)
    observation = Stream.get_observation!(observation_id)

    with :ok <- Bodyguard.permit(Reactions, :delete_like, user, observation) do
      observation_like = Reactions.get_like(user, observation)

      with {:ok, _observation_like} <- Reactions.delete_like(observation_like),
        do: send_resp(conn, :no_content, "")
    end
  end
end
