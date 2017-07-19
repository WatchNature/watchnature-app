defmodule Watchnature.Web.Observation.ObservationImageView do
  use Watchnature.Web, :view

  alias Watchnature.Web.Observation.ObservationImageView

  def render("index.json", %{observation_images: observation_images}) do
    %{data: render_many(observation_images, ObservationImageView, "observation_image.json")}
  end

  def render("show.json", %{observation_image: observation_image}) do
    %{data: render_one(observation_image, ObservationImageView, "observation_image.json")}
  end

  def render("observation_image.json", %{observation_image: observation_image}) do
    %{id: observation_image.id,
      public_id: observation_image.public_id,
      secure_url: observation_image.secure_url,
      url: observation_image.url
    }
  end
end
