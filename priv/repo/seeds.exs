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

alias Watchnature.{Repo, User, Tag}

Repo.insert(User.registration_changeset(%User{}, %{email: "sean@watchnature.co", first_name: "Sean", last_name: "Washington", password: "secret"}))
Repo.insert(User.registration_changeset(%User{}, %{email: "brady@watchnature.co", first_name: "Brady", last_name: "Swenson", password: "secret"}))
Repo.insert(User.registration_changeset(%User{}, %{email: "nicholas@watchnature.co", first_name: "Nicholas", last_name: "Stahl", password: "secret"}))

tags = [
  %{name: "bird", type: :general},
  %{name: "feathers", type: :general},
  %{name: "tree", type: :general},
  %{name: "feeding", type: :behaviors},
  %{name: "perching", type: :behaviors},
  %{name: "red", type: :characteristics},
  %{name: "beak", type: :characteristics},
  %{name: "yellow feet", type: :characteristics},
  %{name: "male", type: :characteristics},
  %{name: "medium sized", type: :characteristics}
]

Enum.each(tags, fn(tag) -> Repo.insert!(Tag.changeset(%Tag{}, tag)) end)
