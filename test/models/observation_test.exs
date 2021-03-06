defmodule Watchnature.Stream.ObservationTest do
  use WatchnatureWeb.ModelCase

  alias Watchnature.{Stream.Observation, Stream.Post, Accounts.User}

  @valid_attrs %{description: "some content", location_name: "some content"}
  @invalid_attrs %{}

  @tag :skip
  test "changeset with valid attributes" do
    post = Repo.insert! %Post{}
    user = Repo.insert! %User{}
    attrs = Map.merge(@valid_attrs, %{user_id: user.id, post_id: post.id})
    changeset = Observation.changeset(%Observation{}, attrs)

    assert changeset.valid?
  end
end
