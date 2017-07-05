defmodule Watchnature.TagTest do
  use Watchnature.Web.ModelCase

  alias Watchnature.Tag

  @valid_attrs %{name: "some content", type: 0}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tag.changeset(%Tag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tag.changeset(%Tag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
