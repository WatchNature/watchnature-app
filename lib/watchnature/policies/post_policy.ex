defmodule Watchnature.Post.Policy do
  alias Watchnature.{User, Post}

  # A user can edit/remove their own post
  def can?(%User{id: user_id} = user, _action, %Post{user_id: post_user_id} = post) do
    case user_id == post_user_id do
      true -> true
      _    -> false
    end
  end

  def can?(_user, :index, Post), do: true
  def can?(_user, :show, _post), do: true

  def can?(_, _, _), do: false
end
