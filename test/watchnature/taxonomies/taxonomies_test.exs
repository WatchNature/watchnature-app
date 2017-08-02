defmodule Watchnature.TaxonomiesTest do
  use Watchnature.DataCase

  alias Watchnature.Taxonomies

  describe "species" do
    alias Watchnature.Taxonomies.Species

    @valid_attrs %{scientific_name: "some name", common_name: "common name", itis_tsn: 1}
    @update_attrs %{scientific_name: "some updated name", common_name: "common updated_name", itis_tsn: 2}
    @invalid_attrs %{scientific_name: nil}

    def species_fixture(attrs \\ %{}) do
      {:ok, species} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Taxonomies.create_species()

      species
    end

    test "list_species/0 returns all species" do
      species = species_fixture()
      assert Taxonomies.list_species() == [species]
    end

    test "get_species!/1 returns the species with given id" do
      species = species_fixture()
      assert Taxonomies.get_species!(species.id) == species
    end

    test "create_species/1 with valid data creates a species" do
      assert {:ok, %Species{} = species} = Taxonomies.create_species(@valid_attrs)
      assert species.name == "some name"
    end

    test "create_species/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taxonomies.create_species(@invalid_attrs)
    end

    test "update_species/2 with valid data updates the species" do
      species = species_fixture()
      assert {:ok, species} = Taxonomies.update_species(species, @update_attrs)
      assert %Species{} = species
      assert species.name == "some updated name"
    end

    test "update_species/2 with invalid data returns error changeset" do
      species = species_fixture()
      assert {:error, %Ecto.Changeset{}} = Taxonomies.update_species(species, @invalid_attrs)
      assert species == Taxonomies.get_species!(species.id)
    end

    test "delete_species/1 deletes the species" do
      species = species_fixture()
      assert {:ok, %Species{}} = Taxonomies.delete_species(species)
      assert_raise Ecto.NoResultsError, fn -> Taxonomies.get_species!(species.id) end
    end

    test "change_species/1 returns a species changeset" do
      species = species_fixture()
      assert %Ecto.Changeset{} = Taxonomies.change_species(species)
    end
  end
end
