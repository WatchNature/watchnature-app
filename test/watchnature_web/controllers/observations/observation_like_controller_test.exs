defmodule WatchnatureWeb.ObservationLikeControllerTest do
  use WatchnatureWeb.ConnCase

  alias Watchnature.Reactions
  alias Watchnature.Reactions.ObservationLike

  import Watchnature.Factory

  setup %{conn: conn} do
    user = insert(:accounts_user)

    {:ok, jwt, full_claims} = Guardian.encode_and_sign(user)

    {:ok, %{
      conn: put_req_header(conn, "accept", "application/json"),
      user: user,
      jwt: jwt,
      claims: full_claims
    }}
  end

  describe "create/2" do
    test "a like is created between the user and observation", %{conn: conn, jwt: jwt, user: user} do
      post = insert(:stream_post)
      observation = insert(:stream_observation)

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(post_observation_observation_like_path(conn, :create, post, observation))

      response = json_response(conn, 201)["data"]

      assert %{"id" => id} = response
      assert Reactions.get_like(user, observation).id == response["id"]
    end
  end

  describe "delete/2" do
    test "a like is deleted between the user and observation when the user owns the like", %{conn: conn, jwt: jwt, user: user} do
      post = insert(:stream_post)
      observation = insert(:stream_observation)
      observation_like = insert(:reactions_observation_like, %{user: user, observation: observation})

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(post_observation_observation_like_path(conn, :create, post, observation))

      assert response(conn, 204)
    end

    test "a like is deleted between the user and observation when the user does not own the like", %{conn: conn, jwt: jwt, user: user} do
      owner_user = insert(:accounts_user)
      post = insert(:stream_post)
      observation = insert(:stream_observation)
      observation_like = insert(:reactions_observation_like, %{user: owner_user, observation: observation})

      conn = build_conn()
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> delete(post_observation_observation_like_path(conn, :create, post, observation))

      assert response(conn, 403)
    end
  end
end
