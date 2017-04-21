defmodule Watchnature.ObservationControllerTest do
  use Watchnature.ConnCase

  alias Watchnature.Observation
  @valid_attrs %{description: "some content", location_name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, observation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    observation = Repo.insert! %Observation{}
    conn = get conn, observation_path(conn, :show, observation)
    assert json_response(conn, 200)["data"] == %{"id" => observation.id,
      "description" => observation.description,
      "user_id" => observation.user_id,
      "post_id" => observation.post_id,
      "location_name" => observation.location_name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, observation_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, observation_path(conn, :create), observation: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Observation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, observation_path(conn, :create), observation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    observation = Repo.insert! %Observation{}
    conn = put conn, observation_path(conn, :update, observation), observation: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Observation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    observation = Repo.insert! %Observation{}
    conn = put conn, observation_path(conn, :update, observation), observation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    observation = Repo.insert! %Observation{}
    conn = delete conn, observation_path(conn, :delete, observation)
    assert response(conn, 204)
    refute Repo.get(Observation, observation.id)
  end
end
