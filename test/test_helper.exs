Application.ensure_all_started(:hound)
ExUnit.start(exclude: [:skip])

Ecto.Adapters.SQL.Sandbox.mode(Watchnature.Repo, :manual)

