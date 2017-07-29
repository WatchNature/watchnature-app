defmodule Watchnature.Web.Observation.ObservationImageView do
  use Watchnature.Web, :view

  alias Watchnature.Web.Observation.ObservationImageView
  alias Watchnature.Media.ObservationImageAttachment

  def render("index.json", %{observation_images: observation_images}) do
    %{data: render_many(observation_images, ObservationImageView, "observation_image.json")}
  end

  def render("show.json", %{observation_image: observation_image}) do
    %{data: render_one(observation_image, ObservationImageView, "observation_image.json")}
  end

  def render("observation_image.json", %{observation_image: observation_image}) do
    %{id: observation_image.id,
      url: ObservationImageAttachment.url({observation_image.url, %{id: observation_image.observation_id}})}
  end
end
