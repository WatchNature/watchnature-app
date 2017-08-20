defmodule Watchnature.Factory do
  use ExMachina.Ecto, repo: Watchnature.Repo

  use Watchnature.Accounts.UserFactory
  use Watchnature.Accounts.GroupFactory
end
