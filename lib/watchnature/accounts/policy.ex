defmodule Watchnature.Accounts.Policy do
  @behavior Bodyguard.Policy

  alias Watchnature.Accounts
  alias Watchnature.Accounts.{User, Group}

  #
  # Users
  #

  def authorize(:list_users, _acting_user_id, _), do: :ok
  def authorize(:get_user, _acting_user_id, user), do: :ok

  def authorize(:update_user, acting_user_id, _) when is_nil(acting_user_id), do: {:error, :unauthorized}

  def authorize(:update_user, acting_user_id, user_id) do
    case "#{acting_user_id}" == user_id do
      true -> :ok
      false -> user_in_group(acting_user_id, "admin")
    end
  end

  def authorize(:delete_user, acting_user_id, user_id),
    do: user_in_group(acting_user_id, "admin")

  def authorize(_, _, _), do: {:error, :unauthorized}

  defp user_in_group(acting_user_id, group \\ "admin") do
    acting_user = Accounts.get_user!(acting_user_id)
    group_names = Accounts.list_group_names_by_user(acting_user)

    case Enum.any?(group_names, &(&1 == group)) do
      true -> :ok
      false -> {:error, :unauthorized}
    end
  end
end
