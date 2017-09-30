defmodule Watchnature.ObservationViewTest do
  use WatchnatureWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View
  import Watchnature.Factory

  alias WatchnatureWeb.ObservationView
  alias Watchnature.Reactions.ObservationLike

  test "renders 404.html" do
    assert render_to_string(WatchnatureWeb.ErrorView, "404.html", []) == "Page not found"
  end

  describe "index.json/1" do
    test "a list of observations is returned" do
      observation = create_observation()
      observations = ObservationView.render("index.json", %{observations: [observation]})

      assert observations = %{data: [observation]}
    end
  end

  describe "observation.json/1" do
    test "when not given a user, key current_user is not present" do
      observation = create_observation()
      current_user =
        ObservationView.render("observation.json", %{observation: observation})
        |> Map.get(:current_user)

      assert current_user == nil
    end

    test "when given a user, key current_user is present" do
      user = insert(:accounts_user)
      observation = create_observation()

      current_user =
        ObservationView.render("observation.json", %{observation: observation, user: user})
        |> Map.get(:current_user)

      assert current_user != nil
    end

    test "when given a user and that user has liked the observation, key current_user contains a like" do
      user = insert(:accounts_user)
      observation = create_observation()
      ol = insert(:reactions_observation_like, %{user: user, observation: observation})

      current_user =
        ObservationView.render("observation.json", %{observation: observation, user: user})
        |> Map.get(:current_user)

      assert current_user = %{like: %ObservationLike{id: ol.id}}
    end
  end

  defp create_observation do
    insert(:stream_observation) |> Repo.preload([:images, :species])
  end
end
