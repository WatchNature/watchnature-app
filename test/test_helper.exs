ExUnit.start(exclude: [:skip])

Application.ensure_all_started(:ex_machina)
Ecto.Adapters.SQL.Sandbox.mode(Watchnature.Repo, :manual)
