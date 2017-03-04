defmodule Watchnature.User do
  use Watchnature.Web, :model

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email])
    |> validate_required([:email])
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_length(:password, min: 6, max: 200)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      # Schemaless changeset, not meant for persisting data
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        # Generate and write password_hash to changeset
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
