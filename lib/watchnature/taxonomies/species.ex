defmodule Watchnature.Taxonomies.Species do
  use Ecto.Schema
  import Ecto.Changeset
  alias Watchnature.Taxonomies.Species


  schema "taxonomies_species" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Species{} = species, attrs) do
    species
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
