defmodule Watchnature.Stream do
  @moduledoc """
  The boundary for the Posts system.
  """

  import Ecto.Query, warn: false

  alias Watchnature.Repo
  alias Watchnature.Stream.{Post, Observation}
  alias Watchnature.Accounts.User
  alias Watchnature.Reactions.ObservationLike

  defdelegate authorize(action, user, params), to: Watchnature.Stream.Policy

  @default_post_preloads [[user: [:groups]], [observations: [:images, :tags, :species]]]

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
    |> Repo.preload(@default_post_preloads)
  end

  def list_posts(%User{} = user) do
    list_posts_with_observation_likes_query(user.id)
    |> Repo.all()
    |> Repo.preload(@default_post_preloads)
  end

  defp list_posts_with_observation_likes_query(user_id) do
    like_query =
      from ol in ObservationLike,
        where: ol.user_id == ^user_id

    from p in Post,
      distinct: true,
      join: o in assoc(p, :observations),
      left_join: ol in assoc(o, :likes),
      preload: [observations: {o, likes: ^like_query}]
  end

  @doc """
  Returns a %Scrivener.Page{} struct with posts and page info.

  ## Examples

      iex> paginate_posts()
      %Scrivener.Page{current_page: 1, entries: [%Post{}, ...]}
      iex> paginate_posts(%{page: 2})
      %Scrivener.Page{current_page: 2, entries: [%Post{}, ...]}

  """
  def paginate_posts(params, user_id) do
    list_posts_with_observation_likes_query(user_id)
    |> Post.sorted
    |> preload(^@default_post_preloads)
    |> Repo.paginate(params)
  end
  def paginate_posts(params) do
    Post
    |> Post.sorted
    |> preload(^@default_post_preloads)
    |> Repo.paginate(params)
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
    |> Repo.preload(@default_post_preloads)
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
        post = post
        |> Repo.preload(@default_post_preloads)
        |> copy_images_with_scope()

        {:ok, post}
      {:error, changset} -> {:error, changset}
    end
  end

  defp copy_images_with_scope(post) do
    observation = post.observations |> List.first()

    for observation_image <- observation.images do
      with {:ok, url} <- Watchnature.Media.upload_attachment(observation_image.url, observation) do
        Watchnature.Media.update_observation_image(observation_image, %{url: url})
      end
    end

    post |> Repo.preload(@default_post_preloads)
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
        post = post |> Repo.preload(@default_post_preloads)
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

  #
  # Observations
  #

  @default_observation_preloads [:images, :tags, :species]

  @doc """
  Gets a single observation.

  Raises `Ecto.NoResultsError` if the observation does not exist.

  ## Examples

      iex> get_observation!(123)
      %Post{}

      iex> get_observation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_observation!(id) do
    Repo.get!(Observation, id)
    |> Repo.preload(@default_observation_preloads)
  end
end
