defmodule Watchnature.MediaTest do
  use Watchnature.DataCase

  alias Watchnature.Media

  describe "observation_images" do
    alias Watchnature.Media.ObservationImage

    @valid_attrs %{url: "http://watchnature.co"}

    def observation_image_fixture(attrs \\ %{}) do
      image_attrs = attrs
      |> Enum.into(@valid_attrs)

      {:ok, post} = Watchnature.Stream.create_post()
      {:ok, observation} = Repo.insert(%Watchnature.Stream.Observation{post_id: post.id})
      {:ok, observation_image} = Media.create_observation_image(observation.id, image_attrs)

      observation_image
    end

    test "list_observation_images/0 returns all observation_images" do
      observation_image = observation_image_fixture()
      assert Media.list_observation_images() == [observation_image]
    end

    test "get_observation_image!/1 returns the observation_image with given id" do
      observation_image = observation_image_fixture()
      assert Media.get_observation_image!(observation_image.id) == observation_image
    end

    test "create_observation_image/1 with valid data creates a observation_image" do
      {:ok, post} = Watchnature.Stream.create_post()
      {:ok, observation} = Repo.insert(%Watchnature.Stream.Observation{post_id: post.id})
      assert {:ok, %ObservationImage{} = observation_image} = Media.create_observation_image(observation.id, @valid_attrs)
      assert observation_image.observation_id == observation.id
      assert observation_image.url == "http://watchnature.co"
    end

    test "delete_observation_image/1 deletes the observation_image" do
      observation_image = observation_image_fixture()
      assert {:ok, %ObservationImage{}} = Media.delete_observation_image(observation_image)
      assert_raise Ecto.NoResultsError, fn -> Media.get_observation_image!(observation_image.id) end
    end

    test "change_observation_image/1 returns a observation_image changeset" do
      observation_image = observation_image_fixture()
      assert %Ecto.Changeset{} = Media.change_observation_image(observation_image)
    end
  end
end
