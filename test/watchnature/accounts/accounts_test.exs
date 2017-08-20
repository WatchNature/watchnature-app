defmodule Watchnature.AccountsTest do
  use Watchnature.DataCase

  import Watchnature.Factory

  alias Watchnature.Accounts

  describe "list_users/0" do
    test "it returns a list of users" do
      user = insert(:accounts_user)

      assert [user] = Accounts.list_users()
    end
  end

  describe "register_user/1" do
    test "with valid params it creates a user" do
      params = string_params_for(:accounts_user)
      assert {:ok, user} = Accounts.register_user(params)
      assert params["email"] == user.email
    end

    test "with invalid params if doesn't create a user" do
      params = string_params_for(:accounts_user)
      |> Map.delete("email")

      assert {:error, %Ecto.Changeset{}} = Accounts.register_user(params)
    end
  end

  describe "get_user!/1" do
    test "it returns the matching user" do
      user = insert(:accounts_user)

      assert user = Accounts.get_user!(user.id)
    end
  end

  describe "update_user/2" do
    test "with valid params it updates a user" do
      user = insert(:accounts_user)

      assert {:ok, user} = Accounts.update_user(user, string_params_for(:accounts_user))
      assert %Accounts.User{} = user
    end
  end

  describe "delete_user/1" do
    test "the specified user is deleted" do
      user = insert(:accounts_user)

      assert {:ok, %Accounts.User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end
  end

  describe "change_user/1" do
    test "it returns a changeset" do
      user = insert(:accounts_user)
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "accounts_groups" do
    alias Watchnature.Accounts.Group

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_group()

      group
    end

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Accounts.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Accounts.get_group!(group.id) == group
    end

    test "get_group_by_name!/1 returns the group with the given name" do
      group = insert(:accounts_group, %{name: "admin"})

      assert Accounts.get_group_by_name!("admin") == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Accounts.create_group(@valid_attrs)
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      assert {:ok, group} = Accounts.update_group(group, @update_attrs)
      assert %Group{} = group
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_group(group, @invalid_attrs)
      assert group == Accounts.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Accounts.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Accounts.change_group(group)
    end
  end
end
