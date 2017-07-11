defmodule Watchnature.CommentTest do
  use Watchnature.Web.ModelCase

  alias Watchnature.{User, Stream.Post, Comment}

  @valid_attrs %{body: "some content", flagged: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    post = Repo.insert! %Post{}
    user = Repo.insert! %User{}
    attrs = Map.merge(@valid_attrs, %{user_id: user.id, post_id: post.id})

    changeset = Comment.changeset(%Comment{}, attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Comment.changeset(%Comment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
