defmodule Watchnature.Accounts.PolicyTest do
  use Watchnature.DataCase

  import Watchnature.Factory

  alias Watchnature.Repo
  alias Watchnature.Accounts

  describe "authorize/3 :update_user" do
    test "when acting_user is nil, it is not permitted" do
      assert {:error, :unauthorized} == Bodyguard.permit(Accounts, :update_user, nil)
    end

    test "when acting_user is the same as user, it is permitted" do
      user = insert(:accounts_user)

      assert :ok == Bodyguard.permit(Accounts, :update_user, user.id, "#{user.id}")
    end

    test "when acting_user is in group admin, it is permitted" do
      group = insert(:accounts_group, %{name: "admin"})
      acting_user = insert(:accounts_user)
      other_user = insert(:accounts_user)

      Accounts.UserGroup.changeset(%Accounts.UserGroup{}, %{user_id: acting_user.id, group_id: group.id})
      |> Repo.insert()

      assert :ok == Bodyguard.permit(Accounts, :update_user, acting_user.id, "#{other_user.id}")
    end

    test "when acting_user is not in group admin, it is not permitted" do
      acting_user = insert(:accounts_user)
      other_user = insert(:accounts_user)

      assert {:error, :unauthorized} == Bodyguard.permit(Accounts, :update_user, acting_user.id, "#{other_user.id}")
    end
  end
end
