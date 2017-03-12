# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Watchnature.Repo.insert!(%Watchnature.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Watchnature.{Repo, User}

Repo.insert!(User.registration_changeset(%User{}, %{email: "sean@watchnature.co", password: "secret"}))
Repo.insert!(User.registration_changeset(%User{}, %{email: "brady@watchnature.co", password: "secret"}))
