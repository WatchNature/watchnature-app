defmodule Watchnature.UserTest do
  use Watchnature.ModelCase

  alias Watchnature.User

  @valid_attrs %{email: "some content", first_name: "sean", last_name: "washington", password_hash: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
