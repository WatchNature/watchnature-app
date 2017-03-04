defmodule Watchnature.PostsControllerTest do
  use Watchnature.ConnCase

  alias Watchnature.Posts
  @valid_attrs %{description: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, posts_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    posts = Repo.insert! %Posts{}
    conn = get conn, posts_path(conn, :show, posts)
    assert json_response(conn, 200)["data"] == %{"id" => posts.id,
      "description" => posts.description,
      "user_id" => posts.user_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, posts_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, posts_path(conn, :create), posts: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Posts, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, posts_path(conn, :create), posts: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    posts = Repo.insert! %Posts{}
    conn = put conn, posts_path(conn, :update, posts), posts: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Posts, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    posts = Repo.insert! %Posts{}
    conn = put conn, posts_path(conn, :update, posts), posts: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    posts = Repo.insert! %Posts{}
    conn = delete conn, posts_path(conn, :delete, posts)
    assert response(conn, 204)
    refute Repo.get(Posts, posts.id)
  end
end
