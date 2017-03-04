defmodule Watchnature.UserView do
  use Watchnature.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Watchnature.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Watchnature.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email}
  end
end
