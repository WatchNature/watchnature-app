defmodule Watchnature.PostControllerTest do
  use Watchnature.ConnCase

  alias Watchnature.{Post, User}

  @valid_attrs %{description: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = Repo.insert! %User{}
    {:ok, jwt, full_claims} = Guardian.encode_and_sign(user)

    {:ok, %{
      conn: put_req_header(conn, "accept", "application/json"),
      user: user,
      jwt: jwt,
      claims: full_claims
    }}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, post_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    post = Repo.insert! %Post{}
    conn = get conn, post_path(conn, :show, post)

    assert json_response(conn, 200)["data"] == %{"id" => post.id,
      "description" => post.description,
      "location" => %{"lat" => nil, "lng" => nil},
      "location_name" => nil,
      "user" => post.user_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, post_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn, jwt: jwt} do
    conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(post_path(conn, :create), post: @valid_attrs)

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Post, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, jwt: jwt} do
    conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(post_path(conn, :create), post: @invalid_attrs)

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn, user: user, jwt: jwt} do
    post = Repo.insert! %Post{user_id: user.id}

    conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(post_path(conn, :update, post), post: @valid_attrs)

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Post, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, user: user, jwt: jwt} do
    post = Repo.insert! %Post{user_id: user.id}

    conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(post_path(conn, :update, post), post: @invalid_attrs)

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn, user: user, jwt: jwt} do
    attrs = Map.merge(@valid_attrs, %{user_id: user.id})
    post = Repo.insert! struct(%Post{}, attrs)

    conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(post_path(conn, :delete, post))

    assert response(conn, 204)
    refute Repo.get(Post, post.id)
  end
end
