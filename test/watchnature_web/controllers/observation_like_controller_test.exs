# defmodule WatchnatureWeb.ObservationLikeControllerTest do
#   use WatchnatureWeb.ConnCase

#   alias Watchnature.Reactions
#   alias Watchnature.Reactions.ObservationLike

#   @create_attrs %{}
#   @update_attrs %{}
#   @invalid_attrs %{}

#   def fixture(:observation_like) do
#     {:ok, observation_like} = Reactions.create_observation_like(@create_attrs)
#     observation_like
#   end

#   setup %{conn: conn} do
#     {:ok, conn: put_req_header(conn, "accept", "application/json")}
#   end

#   describe "index" do
#     test "lists all observation_likes", %{conn: conn} do
#       conn = get conn, observation_like_path(conn, :index)
#       assert json_response(conn, 200)["data"] == []
#     end
#   end

#   describe "create observation_like" do
#     test "renders observation_like when data is valid", %{conn: conn} do
#       conn = post conn, observation_like_path(conn, :create), observation_like: @create_attrs
#       assert %{"id" => id} = json_response(conn, 201)["data"]

#       conn = get conn, observation_like_path(conn, :show, id)
#       assert json_response(conn, 200)["data"] == %{
#         "id" => id}
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post conn, observation_like_path(conn, :create), observation_like: @invalid_attrs
#       assert json_response(conn, 422)["errors"] != %{}
#     end
#   end

#   describe "update observation_like" do
#     setup [:create_observation_like]

#     test "renders observation_like when data is valid", %{conn: conn, observation_like: %ObservationLike{id: id} = observation_like} do
#       conn = put conn, observation_like_path(conn, :update, observation_like), observation_like: @update_attrs
#       assert %{"id" => ^id} = json_response(conn, 200)["data"]

#       conn = get conn, observation_like_path(conn, :show, id)
#       assert json_response(conn, 200)["data"] == %{
#         "id" => id}
#     end

#     test "renders errors when data is invalid", %{conn: conn, observation_like: observation_like} do
#       conn = put conn, observation_like_path(conn, :update, observation_like), observation_like: @invalid_attrs
#       assert json_response(conn, 422)["errors"] != %{}
#     end
#   end

#   describe "delete observation_like" do
#     setup [:create_observation_like]

#     test "deletes chosen observation_like", %{conn: conn, observation_like: observation_like} do
#       conn = delete conn, observation_like_path(conn, :delete, observation_like)
#       assert response(conn, 204)
#       assert_error_sent 404, fn ->
#         get conn, observation_like_path(conn, :show, observation_like)
#       end
#     end
#   end

#   defp create_observation_like(_) do
#     observation_like = fixture(:observation_like)
#     {:ok, observation_like: observation_like}
#   end
# end
