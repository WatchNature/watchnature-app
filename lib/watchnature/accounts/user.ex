defmodule Watchnature.Accounts.User do
  use WatchnatureWeb, :model

  alias Watchnature.{User, Stream.Post, Comment}

  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    has_many :posts, Post
    has_many :comments, Comment

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :first_name, :last_name])
    |> validate_required([:email, :first_name, :last_name])
    |> update_change(:email, &String.downcase/1)
    |> unique_constraint(:email)
  end

  def registration_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> cast(params, [:password, :first_name, :last_name])
    |> validate_required([:email, :first_name, :last_name])
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
