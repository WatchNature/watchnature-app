defmodule Watchnature.ReactionsTest do
  use Watchnature.DataCase

  alias Watchnature.Reactions
  alias Watchnature.Reactions.ObservationLike

  import Watchnature.Factory

  describe "get_like/2" do
    test "it returns an ObservationLike when given one" do
      observation_like = insert(:reactions_observation_like)
      user = observation_like.user
      observation = observation_like.observation

      assert observation_like = Reactions.get_like(user, observation)
    end
  end

  describe "add_like/2" do
    test "it creates an ObservationLike" do
      user = insert(:accounts_user)
      observation = insert(:stream_observation)

      assert {:ok, %ObservationLike{} = observation_like} = Reactions.add_like(user, observation)
      assert observation_like.observation_id == observation.id
      assert observation_like.user_id == user.id
    end

    test "a user cannot like an observation more than once" do
      user = insert(:accounts_user)
      observation = insert(:stream_observation)

      assert {:ok, %ObservationLike{}} = Reactions.add_like(user, observation)
      assert {:error, %Ecto.Changeset{}} = Reactions.add_like(user, observation)
    end
  end

  describe "delete_like/2" do
    test "it deletes an ObservationLike given one" do
      observation_like = insert(:reactions_observation_like)

      assert {:ok, %ObservationLike{}} = Reactions.delete_like(observation_like)
      # assert_raise Ecto.NoResultsError, fn -> Reactions.get_observation_like!(observation_like.id) end
    end
  end

  describe "get_stats/1" do
    test "it returns a stat struct" do
      user = insert(:accounts_user)
      observation = insert(:stream_observation)
      observation_like = insert(:reactions_observation_like, %{observation: observation})

      assert %Reactions.Stat{likes: 1} = Reactions.get_stats(observation)
    end
  end
end
