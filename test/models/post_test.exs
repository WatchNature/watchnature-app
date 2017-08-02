defmodule Watchnature.PostTest do
  use WatchnatureWeb.ModelCase

  alias Watchnature.Stream.Post

  @valid_attrs %{description: "some content"}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end
end
