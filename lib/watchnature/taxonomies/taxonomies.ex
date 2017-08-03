defmodule Watchnature.Taxonomies do
  @moduledoc """
  The boundary for the Taxonomies system.
  """

  import Ecto.Query, warn: false

  alias Watchnature.Repo
  alias Watchnature.Taxonomies.{Species, Query}

  @doc """
  Returns the list of species.

  ## Examples

      iex> list_species()
      [%Species{}, ...]

  """
  def list_species do
    Repo.all(Species)
  end

  @doc """
  Returns a Scrivener struct of species

  ## Examples

      iex> paginate_species()
      [%Species{}, ...]

  """
  def paginate_species(params \\ []) do
    Repo.paginate(Species, params)
  end

  @doc """
  Returns a Scrivener struct with matching species

  ## Examples

      iex> search_species_by_name("wolf")
      [%Species{}, ...]

  """
  def search_species_by_name(name, page_params \\ []) do
    Species
    |> Query.by_name(name)
    |> Repo.paginate(page_params)
  end

  @doc """
  Gets a single species.

  Raises `Ecto.NoResultsError` if the Species does not exist.

  ## Examples

      iex> get_species!(123)
      %Species{}

      iex> get_species!(456)
      ** (Ecto.NoResultsError)

  """
  def get_species!(id), do: Repo.get!(Species, id)

  @doc """
  Creates a species.

  ## Examples

      iex> create_species(%{field: value})
      {:ok, %Species{}}

      iex> create_species(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_species(attrs \\ %{}) do
    %Species{}
    |> Species.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a species.

  ## Examples

      iex> update_species(species, %{field: new_value})
      {:ok, %Species{}}

      iex> update_species(species, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_species(%Species{} = species, attrs) do
    species
    |> Species.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Species.

  ## Examples

      iex> delete_species(species)
      {:ok, %Species{}}

      iex> delete_species(species)
      {:error, %Ecto.Changeset{}}

  """
  def delete_species(%Species{} = species) do
    Repo.delete(species)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking species changes.

  ## Examples

      iex> change_species(species)
      %Ecto.Changeset{source: %Species{}}

  """
  def change_species(%Species{} = species) do
    Species.changeset(species, %{})
  end
end
