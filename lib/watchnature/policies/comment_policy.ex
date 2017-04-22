defmodule Watchnature.Comment.Policy do
  alias Watchnature.{User, Comment}

  # A user can edit/remove their own post
  def can?(%User{id: user_id} = user, _action, %Comment{user_id: comment_user_id} = post) do
    case user_id == comment_user_id do
      true -> true
      _    -> false
    end
  end

  def can?(_user, :index, Comment), do: true
  def can?(_user, :show, _comment), do: true

  def can?(_, _, _), do: false
end
