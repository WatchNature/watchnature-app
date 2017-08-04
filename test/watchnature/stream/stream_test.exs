defmodule Watchnature.StreamTest do
  use Watchnature.DataCase

  alias Watchnature.Stream

  # describe "post" do
  #   alias Watchnature.Stream.Post

  #   @valid_attrs %{description: "some description"}
  #   @update_attrs %{description: "some updated description"}
  #   @invalid_attrs %{}

  #   def post_fixture(attrs \\ %{}) do
  #     {:ok, post} =
  #       attrs
  #       |> Enum.into(@valid_attrs)
  #       |> Stream.create_post()

  #     post
  #   end

  #   test "list_posts/0 returns all posts" do
  #     post = post_fixture()
  #     assert Stream.list_posts() == [post]
  #   end

  #   test "get_post!/1 returns the post with given id" do
  #     post = post_fixture()
  #     assert Stream.get_post!(post.id) == post
  #   end

  #   test "create_post/1 with valid data creates a post" do
  #     {:ok, post} = Stream.create_post(@valid_attrs)
  #     assert post.description == "some description"
  #   end

  #   test "update_post/2 with valid data updates the post" do
  #     post = post_fixture()
  #     assert {:ok, post} = Stream.update_post(post, @update_attrs)
  #     assert %Post{} = post
  #     assert post.description == "some updated description"
  #   end

  #   test "delete_post/1 deletes the post" do
  #     post = post_fixture()
  #     assert {:ok, %Post{}} = Stream.delete_post(post)
  #     assert_raise Ecto.NoResultsError, fn -> Stream.get_post!(post.id) end
  #   end

  #   test "change_post/1 returns a post changeset" do
  #     post = post_fixture()
  #     assert %Ecto.Changeset{} = Stream.change_post(post)
  #   end
  # end
end
