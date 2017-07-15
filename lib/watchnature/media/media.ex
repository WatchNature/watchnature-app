defmodule Watchnature.Media do
  @moduledoc """
  The boundary for the Media system.
  """

  import Ecto.Query, warn: false
  alias Watchnature.Repo

  alias Watchnature.Media.ObservationImage

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
  Creates a observation_image.

  ## Examples

      iex> create_observation_image(%{field: value})
      {:ok, %ObservationImage{}}

      iex> create_observation_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_observation_image(attrs \\ %{}) do
    %ObservationImage{}
    |> ObservationImage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a observation_image.

  ## Examples

      iex> update_observation_image(observation_image, %{field: new_value})
      {:ok, %ObservationImage{}}

      iex> update_observation_image(observation_image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_observation_image(%ObservationImage{} = observation_image, attrs) do
    observation_image
    |> ObservationImage.changeset(attrs)
    |> Repo.update()
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
