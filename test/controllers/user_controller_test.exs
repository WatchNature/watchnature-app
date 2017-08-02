defmodule Watchnature.UserControllerTest do
  use WatchnatureWeb.ConnCase

  alias Watchnature.User
  @valid_attrs %{email: "sean@watchnature.co", first_name: "sean", last_name: "washington", password: "secretsecret"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    Repo.delete_all(User)

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
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)
  end

  test "shows chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = get conn, user_path(conn, :show, user)
    assert json_response(conn, 200)["data"]["id"] == user.id
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, %{email: @valid_attrs[:email]})
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn, jwt: jwt} do
    user = Repo.insert! %User{}

    conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(user_path(conn, :update, user), user: @valid_attrs)

    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(User, %{email: @valid_attrs[:email]})
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, jwt: jwt} do
    user = Repo.insert! %User{}

    conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> put(user_path(conn, :update, user), user: @invalid_attrs)

    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn, jwt: jwt} do
    user = Repo.insert! %User{}

    conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(user_path(conn, :delete, user))

    assert response(conn, 204)
    refute Repo.get(User, user.id)
  end
end
