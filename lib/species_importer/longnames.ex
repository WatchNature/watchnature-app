defmodule SpeciesImporter.Longnames do
  use Ecto.Schema

  @primary_key false
  schema "longnames" do
    field :tsn, :integer
    field :completename, :string
  end
end
