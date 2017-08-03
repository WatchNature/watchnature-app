defmodule WatchnatureWeb.SpeciesController do
  use WatchnatureWeb, :controller

  alias Watchnature.Taxonomies

  def index(conn, %{"term" => term} = params) do
    page_number = Map.get(params, "page", 1)
    page = Taxonomies.search_species_by_name(term, [page: page_number])
    render(conn, "index.json", species: page.entries, meta: build_page_meta(page))
  end
  def index(conn, params) do
    page_number = Map.get(params, "page", 1)
    page = Taxonomies.paginate_species([page: page_number])
    render(conn, "index.json", species: page.entries, meta: build_page_meta(page))
  end

  defp build_page_meta(page) do
    %{page_number: page.page_number,
      page_size: page.page_size,
      total_pages: page.total_pages,
      total_entries: page.total_entries}
  end
end
