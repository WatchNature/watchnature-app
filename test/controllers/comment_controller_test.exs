defmodule Watchnature.CommentControllerTest do
  use Watchnature.ConnCase

  alias Watchnature.{Comment, User, Post}

  @valid_attrs %{body: "some content", flagged: true}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = Repo.insert! %User{}
    post = Repo.insert! %Post{user_id: user.id}
    {:ok, jwt, full_claims} = Guardian.encode_and_sign(user)

    {:ok, %{
      conn: put_req_header(conn, "accept", "application/json"),
      user: user,
      post: post,
      jwt: jwt,
      claims: full_claims
    }}
  end

  test "lists all entries on index", %{conn: conn, post: post} do
    conn = get conn, post_comment_path(conn, :index, post)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn, post: post} do
    comment = Repo.insert! %Comment{}
    conn = get conn, post_comment_path(conn, :show, post, comment)
    assert json_response(conn, 200)["data"] == %{"id" => comment.id,
      "body" => comment.body,
      "post_id" => comment.post_id,
      "user_id" => comment.user_id,
      "flagged" => comment.flagged}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, post_comment_path(conn, :show, -1, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn, post: post, jwt: jwt} do
    conn = build_conn()
    |> put_req_header("authorization", "Bearer #{jwt}")
    |> post(post_comment_path(conn, :create, post), comment: @valid_attrs)

    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Comment, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, post: post, jwt: jwt} do
    conn = build_conn()
    |> put_req_header("authorization", "Bearer #{jwt}")
    |> post(post_comment_path(conn, :create, post), comment: @invalid_attrs)

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn, post: post, user: user, jwt: jwt} do
    comment = Repo.insert! %Comment{post_id: post.id, user_id: user.id}

    conn = build_conn()
    |> put_req_header("authorization", "Bearer #{jwt}")
    |> put(post_comment_path(conn, :update, post, comment), comment: @valid_attrs)

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Comment, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, post: post, jwt: jwt} do
    comment = Repo.insert! %Comment{}

    conn = build_conn()
    |> put_req_header("authorization", "Bearer #{jwt}")
    |> put(post_comment_path(conn, :update, post, comment), comment: @invalid_attrs)

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn, post: post, jwt: jwt} do
    comment = Repo.insert! %Comment{}

    conn = build_conn()
    |> put_req_header("authorization", "Bearer #{jwt}")
    |> delete(post_comment_path(conn, :delete, post, comment))

    assert response(conn, 204)
    refute Repo.get(Comment, comment.id)
  end
end
