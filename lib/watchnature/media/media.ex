defmodule Watchnature.Media do
  @moduledoc """
  The boundary for the Media system.
  """

  import Ecto.Query, warn: false

  alias Watchnature.Repo
  alias Watchnature.Media.{ObservationImage, ObservationImageAttachment}

  @aws_bucket_name System.get_env("AWS_BUCKET_NAME")
  @aws_access_key System.get_env("AWS_ACCESS_KEY_ID")

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
  Uploads an attachment file to S3

  ## Examples

    iex> upload_attachment(%Plug.Upload{}, %Observation{id: 1})
    {:ok, "filename.type"}

  """
  def upload_attachment(%Plug.Upload{} = file), do: ObservationImageAttachment.store(file)
  def upload_attachment(file, scope), do: ObservationImageAttachment.store({file, scope})

  @doc """
  Returns the URL corresponding to an attachment.

  ## Examples

    iex> get_attachment_url("some_image.png")
    "https://someurl.com/some_image.png"
    iex> get_attachment_url("some_image.png", %Observation{id: 1})
    "https://someurl.com/1/some_image.png"

  """
  def get_attachment_url(path), do: ObservationImageAttachment.url(path)
  def get_attachment_url(path, scope), do: ObservationImageAttachment.url({path, scope})

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
  Updates an ObservationImage.

  ## Examples

      iex> update_observation_image(observation_image, %{field: new_value})
      {:ok, %ObservationImage{}}

      iex> update_observation_image(observation_image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_observation_image(%ObservationImage{} = observation_image, attrs) do
    observation_image = observation_image
    |> ObservationImage.changeset(attrs)
    |> Repo.update()
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
