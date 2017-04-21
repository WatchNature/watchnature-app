defmodule Watchnature.Observation.Policy do
  alias Watchnature.{User, Observation}

  # def can?(%User{id: user_id}, _action, %Observation{user_id: observation_user_id}) do
  #   case user_id == observation_user_id do
  #     true -> true
  #     _    -> false
  #   end
  # end

  # def can?(_user, :index, Observation), do: true
  # def can?(_user, :show, _observation), do: true
end
