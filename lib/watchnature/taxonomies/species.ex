defmodule Watchnature.Taxonomies.Species do
  use Ecto.Schema
  import Ecto.Changeset
  alias Watchnature.Taxonomies.Species

  schema "species" do
    field :common_name, :string
    field :scientific_name, :string
    field :itis_tsn, :integer

    timestamps()
  end

  @doc false
  def changeset(%Species{} = species, attrs) do
    species
    |> cast(attrs, [:common_name, :scientific_name, :itis_tsn])
    |> validate_required([:common_name, :scientific_name, :itis_tsn])
  end
end
