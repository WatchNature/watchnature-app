defmodule Watchnature.Taxonomies.Query do
  import Ecto.Query

  alias Watchnature.Taxonomies.Species

  def by_name(queryable \\ __MODULE__, term) do
    from s in queryable,
    where: ilike(s.common_name, ^"%#{term}%")
           or ilike(s.scientific_name, ^"%#{term}%")
  end
end
