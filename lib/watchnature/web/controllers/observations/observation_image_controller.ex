defmodule Watchnature.Web.Observation.ObservationImageController do
  use Watchnature.Web, :controller

  alias Watchnature.Media

  def index(conn) do
    images = Media.list_observation_images()
    render(conn, "index.json", images: images)
  end

  def create(conn, %{observation_id: observation_id} = params) do
    with {:ok, image} <- Media.create_observation_image(observation_id, params) do
      render(conn, "show.json", image: image)
    end
  end

  def delete(conn, %{"id" => observation_image_id}) do
    with {:ok, image} <- Media.create_observation_image(observation_image_id) do
      render(conn, "show.json", image: image)
    end
  end
end
