defmodule Watchnature.Stream.ObservationFactory do
  defmacro __using__(_opts) do
    quote do
      def stream_observation_factory do
        %Watchnature.Stream.Observation{
          description: "some description",
          location: %{"coordinates" => ["43.8209008", "-82.5212089"], "type" => "Point"},
          location_name: "some location"
        }
      end
    end
  end
end
