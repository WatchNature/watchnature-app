defmodule Watchnature.Taxonomies.Query do
  import Ecto.Query

  alias Watchnature.Taxonomies.Species

  def by_name(queryable \\ __MODULE__, term) do
    term = String.downcase(term)

    from s in queryable,
    where: like(fragment("lower(?)", s.common_name), ^"%#{term}%")
           or like(fragment("lower(?)", s.scientific_name), ^"%#{term}%")
  end
end
