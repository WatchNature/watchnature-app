defmodule Watchnature.ObservationTest do
  use Watchnature.ModelCase

  alias Watchnature.{Observation, Post, User}

  @valid_attrs %{description: "some content", location_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    post = Repo.insert! %Post{}
    user = Repo.insert! %User{}
    attrs = Map.merge(@valid_attrs, %{user_id: user.id, post_id: post.id})
    changeset = Observation.changeset(%Observation{}, attrs)

    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Observation.changeset(%Observation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
