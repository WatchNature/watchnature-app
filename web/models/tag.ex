defmodule Watchnature.Tag do
  use Watchnature.Web, :model

  schema "tags" do
    field :name, :string
    field :type, TypeEnum

    many_to_many :observations, Watchnature.Observation, join_through: Watchnature.ObservationTag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :type])
    |> validate_required([:name, :type])
  end
end
