defmodule Watchnature.Stream.Policy do
  @behavior Bodyguard.Policy

  alias Watchnature.{Stream, Stream.Post, Stream.Observation}
  alias Watchnature.Accounts
  alias Watchnature.Accounts.User

  #
  # Posts
  #

  def authorize(:create_post, user_id, _) when is_nil(user_id), do: {:error, :unauthorized}
  def authorize(:create_post, user_id, _), do: :ok

  def authorize(:update_post, user_id, post_user_id) do
    case user_id == post_user_id do
      true -> :ok
      false -> user_in_group(user_id, "admin")
    end
  end

  def authorize(:list_posts, _user, _), do: :ok
  def authorize(:paginate_posts, _user, _), do: :ok
  def authorize(:get_post, _user, _post), do: :ok

  def authorize(:delete_post, acting_user_id, _post),
    do: user_in_group(acting_user_id, "admin")

  def authorize(_, _, _), do: {:error, :unauthorized}

  #
  # Observations
  #

  def authorize?(action, %User{id: user_id}, %Observation{post_id: post_id}) do
    post = Stream.get_post!(post_id)

    case user_id == post.user_id do
      true -> :ok
      _    -> {:error, :unauthorized}
    end
  end

  def authorize?(:list_observations, _user, _), do: true
  def authorize?(:get_observation, _user, _observation), do: :ok
  def authorize?(_, _, _), do: {:error, :unauthorized}

  defp user_in_group(acting_user_id, group \\ "admin") do
    acting_user = Accounts.get_user!(acting_user_id)
    group_names = Accounts.list_group_names_by_user(acting_user)

    case Enum.any?(group_names, &(&1 == group)) do
      true -> :ok
      false -> {:error, :unauthorized}
    end
  end
end
