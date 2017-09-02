defmodule Watchnature.Reactions.LikeFactory do
  defmacro __using__(_opts) do
    quote do
      def reactions_observation_like_factory do
        %Watchnature.Reactions.ObservationLike{
          observation: build(:stream_observation),
          user: build(:accounts_user)
        }
      end
    end
  end
end
