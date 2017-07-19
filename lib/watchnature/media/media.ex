defmodule Watchnature.Media do
  @moduledoc """
  The boundary for the Media system.
  """

  import Ecto.Query, warn: false

  alias Watchnature.Repo
  alias Watchnature.Media.ObservationImage

  @bucket_name System.get_env("AWS_BUCKET_NAME")

  @doc """
  Returns the list of observation_images.

  ## Examples

      iex> list_observation_images()
      [%ObservationImage{}, ...]

  """
  def list_observation_images do
    Repo.all(ObservationImage)
  end

  @doc """
  Gets a single observation_image.

  Raises `Ecto.NoResultsError` if the Observation image does not exist.

  ## Examples

      iex> get_observation_image!(123)
      %ObservationImage{}

      iex> get_observation_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_observation_image!(id), do: Repo.get!(ObservationImage, id)

  @doc """
  Creates an Observation Image

  ## Examples

      iex> create_observation_image(123, %{field: value})
      {:ok, %ObservationImage{}}

      iex> create_observation_image(123, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_observation_image(observation_id \\ nil, attrs \\ %{}) do
    %ObservationImage{observation_id: observation_id}
    |> ObservationImage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns a presigned post url to be used by the client for
  direct upload to S3.

  ## Examples

    iex> create_presigned_post_url
    {:ok, "url"}

  """
  def create_presigned_post_url do
    ExAws.Config.new(:s3)
    |> ExAws.S3.presigned_url(:post, @bucket_name, "/")
  end

  @doc """
  Deletes a ObservationImage.

  ## Examples

      iex> delete_observation_image(observation_image)
      {:ok, %ObservationImage{}}

      iex> delete_observation_image(observation_image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_observation_image(%ObservationImage{} = observation_image) do
    Repo.delete(observation_image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking observation_image changes.

  ## Examples

      iex> change_observation_image(observation_image)
      %Ecto.Changeset{source: %ObservationImage{}}

  """
  def change_observation_image(%ObservationImage{} = observation_image) do
    ObservationImage.changeset(observation_image, %{})
  end
end
