defmodule Watchnature.PostsTest do
  use Watchnature.ModelCase

  alias Watchnature.Posts

  @valid_attrs %{description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Posts.changeset(%Posts{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Posts.changeset(%Posts{}, @invalid_attrs)
    refute changeset.valid?
  end
end
