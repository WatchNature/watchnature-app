defmodule WatchnatureWeb.SpeciesView do
  use WatchnatureWeb, :view

  def render("index.json", %{species: species, meta: meta}) do
    %{data: render_many(species, WatchnatureWeb.SpeciesView, "species.json"),
      meta: meta}
  end

  def render("show.json", %{species: species}) do
    %{data: render_one(species, WatchnatureWeb.SpeciesView, "species.json")}
  end

  def render("species.json", %{species: species}) do
    %{id: species.id,
      common_name: species.common_name,
      scientific_name: species.scientific_name}
  end
end
