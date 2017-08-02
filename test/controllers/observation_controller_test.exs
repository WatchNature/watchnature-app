defmodule Watchnature.ObservationControllerTest do
  use WatchnatureWeb.ConnCase

  alias Watchnature.{Observation, Stream.Post, User}

  @valid_attrs %{description: "some content", location_name: "some content"}
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

  # test "entries listed on index belong to post_id", %{conn: conn, user: user, post: post} do
  #   observation = Repo.insert! %Observation{post: post, user: user}
  #   conn = get conn, post_observation_path(conn, :index, post)

  #   assert json_response(conn, 200)["data"] == [%{"id" => observation.id,
  #     "description" => observation.description,
  #     "user_id" => user.id,
  #     "post_id" => post.id,
  #     "location_name" => observation.location_name}]
  # end

  # test "shows chosen resource", %{conn: conn, post: post} do
  #   observation = Repo.insert! %Observation{}
  #   conn = get conn, post_observation_path(conn, :show, post, observation)

  #   assert json_response(conn, 200)["data"] == %{"id" => observation.id,
  #     "description" => observation.description,
  #     "user_id" => observation.user_id,
  #     "post_id" => observation.post_id,
  #     "location_name" => observation.location_name}
  # end

  # test "renders page not found when id is nonexistent", %{conn: conn, post: post} do
  #   assert_error_sent 404, fn ->
  #     get conn, post_observation_path(conn, :show, post, -1)
  #   end
  # end

  # test "creates and renders resource when data is valid", %{conn: conn, jwt: jwt, post: post} do
  #   conn = build_conn()
  #   |> put_req_header("authorization", "Bearer #{jwt}")
  #   |> post(post_observation_path(conn, :create, post), observation: @valid_attrs)

  #   assert json_response(conn, 201)["data"]["id"]
  #   assert Repo.get_by(Observation, @valid_attrs)
  # end

  # test "does not create resource and renders errors when data is invalid", %{conn: conn, jwt: jwt, post: post} do
  #   conn = build_conn()
  #   |> put_req_header("authorization", "Bearer #{jwt}")
  #   |> post(post_observation_path(conn, :create, post), observation: @invalid_attrs)

  #   assert json_response(conn, 422)["errors"] != %{}
  # end

  # test "updates and renders chosen resource when data is valid", %{conn: conn, jwt: jwt, user: user, post: post} do
  #   observation = Repo.insert! %Observation{user: user, post: post}

  #   conn = build_conn()
  #   |> put_req_header("authorization", "Bearer #{jwt}")
  #   |> put(post_observation_path(conn, :update, post, observation), observation: @valid_attrs)

  #   assert json_response(conn, 200)["data"]["id"]
  #   assert Repo.get_by(Observation, @valid_attrs)
  # end

  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, jwt: jwt, user: user, post: post} do
  #   observation =
  #     Repo.insert!(%Observation{user: user, post: post})

  #   conn = build_conn()
  #   |> put_req_header("authorization", "Bearer #{jwt}")
  #   |> put(post_observation_path(conn, :update, post, observation), observation: @invalid_attrs)

  #   assert json_response(conn, 422)["errors"] != %{}
  # end

  # test "deletes chosen resource", %{conn: conn, user: user, post: post, jwt: jwt} do
  #   observation = Repo.insert! %Observation{user: user, post: post}

  #   conn = build_conn()
  #   |> put_req_header("authorization", "Bearer #{jwt}")
  #   |> delete(post_observation_path(conn, :delete, post, observation))

  #   assert response(conn, 204)
  #   refute Repo.get(Observation, observation.id)
  # end
end
