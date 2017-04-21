defmodule Watchnature.ObservationTest do
  use Watchnature.ModelCase

  alias Watchnature.Observation

  @valid_attrs %{description: "some content", location_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Observation.changeset(%Observation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Observation.changeset(%Observation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
