defmodule WatchnatureWeb.CommentView do
  use WatchnatureWeb, :view

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, WatchnatureWeb.CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, WatchnatureWeb.CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      body: comment.body,
      post_id: comment.post_id,
      user_id: comment.user_id,
      flagged: comment.flagged}
  end
end
