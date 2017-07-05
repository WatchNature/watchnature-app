defmodule Watchnature.ObservationTag do
  use Watchnature.Web, :model

  schema "observation_tags" do
    belongs_to :observation, Watchnature.Observation
    belongs_to :tag, Watchnature.Tag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:tag_id, :observation_id])
    |> validate_required([:tag_id, :observation_id])
  end
end
