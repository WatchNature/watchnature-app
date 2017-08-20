defmodule Watchnature.Stream.Policy do
  @behaviour Bodyguard.Policy

  alias Watchnature.{Stream, Accounts.User, Stream.Post, Stream.Observation}

  ### Posts

  def authorize(:create_post, user_id, _) when is_nil(user_id), do: {:error, :unauthorized}
  def authorize(:create_post, user_id, _), do: :ok

  def authorize(action, %User{id: user_id}, %Post{user_id: post_user_id})
    when action in [:update_post, :delete_post]
    and user_id == post_user_id, do: :ok

  def authorize(:list_posts, _user, _), do: :ok
  def authorize(:paginate_posts, _user, _), do: :ok
  def authorize(:get_post, _user, post), do: :ok

  def authorize(_, _, _), do: {:error, :unauthorized}

  ### Observations

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
end
