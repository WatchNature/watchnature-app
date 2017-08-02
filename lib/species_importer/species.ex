defmodule SpeciesImporter.Species do
  import Ecto.Query

  alias SpeciesImporter.{Vernaculars, Longnames}

  @doc """
  Returns an Ecto.Query struct for joining vernaculars and longnames together

  ## Examples

    iex> SpeciesImporter.Repo.all(SpeciesImporter.Species.names)

  """
  def names do
    from v in Vernaculars,
    distinct: true,
    join: l in Longnames, on: v.tsn == l.tsn,
    where: v.language == "English",
    or_where: v.language == "unspecified",
    select: {v.tsn, v.vernacular_name, l.completename}
  end
end
