defmodule Watchnature.Stream.PostFactory do
  defmacro __using__(_opts) do
    quote do
      def stream_post_factory do
        %Watchnature.Stream.Post{
          description: "some description",
          location: %{"coordinates" => ["43.8209008", "-82.5212089"], "type" => "Point"},
          location_name: "some location",
          user: build(:accounts_user)
        }
      end
    end
  end
end
