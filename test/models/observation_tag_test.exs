defmodule Watchnature.ObservationTagTest do
  use Watchnature.Web.ModelCase

  alias Watchnature.ObservationTag

  @valid_attrs %{tag_id: 1, observation_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ObservationTag.changeset(%ObservationTag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ObservationTag.changeset(%ObservationTag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
