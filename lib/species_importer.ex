defmodule SpeciesImporter do
  @moduledoc """
  SpeciesImporter handles connecting to the [ITIS database](https://www.itis.gov/downloads/) and importing species into the WatchNature database.
  """

  def import do
    SpeciesImporter.Repo.all(SpeciesImporter.Species.names)
    |> Enum.each(fn(result) ->
      {tsn, common_name, scientific_name} = result

      %{common_name: String.downcase(common_name),
        scientific_name: String.downcase(scientific_name),
        itis_tsn: tsn} |> create_species()
    end)
  end

  defp create_species(species) do
    Watchnature.Taxonomies.create_species(species)
  end
end
