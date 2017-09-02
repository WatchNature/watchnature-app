defmodule Watchnature.Reactions.Policy do
  @behavior Bodyguard.Policy

  alias Watchnature.Reactions
  alias Watchnature.Reactions.ObservationLike
  alias Watchnature.Accounts.User
  alias Watchnature.Stream.Observation

  def authorize(:add_like, acting_user_id, _) when is_nil(acting_user_id), do: {:error, :unauthorized}
  def authorize(:add_like, _acting_user_id, _), do: :ok

  def authorize(:delete_like, acting_user_id, _) when is_nil(acting_user_id), do: {:error, :unauthorized}
  def authorize(:delete_like, %User{} = acting_user, %Observation{} = observation) do
    case Reactions.get_like(acting_user, observation) do
      nil -> :error
      _ -> :ok
    end
  end

  def authorize(_, _, _), do: {:error, :unauthorized}
end
