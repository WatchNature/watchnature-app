defmodule Watchnature.Stream do
  @moduledoc """
  The boundary for the Posts system.
  """

  import Ecto.Query, warn: false
  alias Watchnature.Repo
  alias Watchnature.Stream.Post

  use Bodyguard.Policy, policy: Watchnature.Stream.Policy

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Post
    |> Post.sorted
    |> Repo.all
    |> Repo.preload([:user, :observations])
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the posts does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
    Repo.get!(Post, id)
    |> Repo.preload([:user, :observations])
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    post = %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()

    case post do
      {:ok, post} ->
        post = post |> Repo.preload([:user, :observations])
        {:ok, post}
      {:error, changset} -> {:error, changset}
    end
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_posts(posts, %{field: new_value})
      {:ok, %Posts{}}

      iex> update_posts(posts, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post = post
    |> Post.changeset(attrs)
    |> Repo.update()

    case post do
      {:ok, post} ->
        post = post |> Repo.preload([:user, :observations])
        {:ok, post}
      {:error, changset} -> {:error, changset}
    end
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
