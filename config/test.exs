use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :watchnature, Watchnature.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :watchnature, Watchnature.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "watchnature_test",
  username: System.get_env("POSTGRES_USER") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  port:     System.get_env("POSTGRES_PORT") || "5432",
  types: Watchnature.PostgresTypes,
  pool: Ecto.Adapters.SQL.Sandbox
