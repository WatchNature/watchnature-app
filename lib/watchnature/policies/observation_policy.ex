defmodule Watchnature.Observation.Policy do
  alias Watchnature.{Stream, User, Observation}

  def can?(%User{id: user_id}, _action, %Observation{post_id: post_id}) do
    post = Stream.get_post!(post_id)

    case user_id == post.user_id do
      true -> true
      _    -> false
    end
  end

  def can?(_user, :index, Observation), do: true
  def can?(_user, :show, _observation), do: true
  def can?(_, _, _), do: false
end
