defmodule Watchnature.Factory do
  use ExMachina.Ecto, repo: Watchnature.Repo

  use Watchnature.Accounts.UserFactory
  use Watchnature.Accounts.GroupFactory

  use Watchnature.Stream.PostFactory
  use Watchnature.Stream.ObservationFactory

  use Watchnature.Reactions.LikeFactory
end
