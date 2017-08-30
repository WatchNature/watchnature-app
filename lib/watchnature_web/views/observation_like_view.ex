defmodule WatchnatureWeb.ObservationLikeView do
  use WatchnatureWeb, :view
  alias WatchnatureWeb.ObservationLikeView

  def render("index.json", %{observation_likes: observation_likes}) do
    %{data: render_many(observation_likes, ObservationLikeView, "observation_like.json")}
  end

  def render("show.json", %{observation_like: observation_like}) do
    %{data: render_one(observation_like, ObservationLikeView, "observation_like.json")}
  end

  def render("observation_like.json", %{observation_like: observation_like}) do
    %{id: observation_like.id}
  end
end
