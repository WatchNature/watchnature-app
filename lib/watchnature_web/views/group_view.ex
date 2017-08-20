defmodule WatchnatureWeb.GroupView do
  use WatchnatureWeb, :view

  def render("index.json", %{groups: groups}) do
    %{data: render_many(groups, WatchnatureWeb.GroupView, "groups.json")}
  end

  def render("show.json", %{group: group}) do
    %{data: render_one(group, WatchnatureWeb.GroupView, "group.json")}
  end

  def render("group.json", %{group: group}) do
    %{id: group.id,
      name: group.name}
  end
end
