defmodule Watchnature.Web.UserView do
  use Watchnature.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Watchnature.Web.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Watchnature.Web.UserView, "user.json")}
  end

  def render("authenticated.json", %{user: user, token: token}) do
    %{data: %{id: user.id, full_name: user_fullname(user), email: user.email}, meta: %{token: token}}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      full_name: user_fullname(user)}
  end

  defp user_fullname(user) do
    "#{user.first_name} #{user.last_name}"
  end
end
