defmodule Watchnature.Stream.Policy do
  @moduledoc """
  """

  alias Watchnature.{User, Stream.Post}

  @behaviour Bodyguard.Policy

  def authorize(:create_post, user_id, _) when is_nil(user_id), do: {:error, :unauthorized}
  def authorize(:create_post, user_id, _), do: :ok

  def authorize(action, %User{id: user_id}, %Post{user_id: post_user_id})
    when action in [:update_post, :delete_post]
    and user_id == post_user_id, do: :ok

  def authorize(:list_posts, _user, _), do: :ok
  def authorize(:get_post, _user, post), do: :ok

  def authorize(_, _, _), do: {:error, :unauthorized}
end
