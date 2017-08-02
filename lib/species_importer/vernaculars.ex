defmodule SpeciesImporter.Vernaculars do
  use Ecto.Schema

  @primary_key false
  schema "vernaculars" do
    field :tsn, :integer
    field :language, :string
    field :vernacular_name, :string
  end
end
