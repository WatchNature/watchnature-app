# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

if Mix.env == :dev do
  config :mix_test_watch,
    clear: true
end

# General application configuration
config :watchnature,
  ecto_repos: [Watchnature.Repo]
  # ecto_repos: [Watchnature.Repo, SpeciesImporter.Repo]

# Configures the endpoint
config :watchnature, WatchnatureWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pleZSV6qhDu0Sv+Reyy2LSaSI5+6RhFe1vrB4mur735GxmTzhJ020lV1mHok1OWp",
  render_errors: [view: WatchnatureWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Watchnature.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    identity: {
      Ueberauth.Strategy.Identity,
      [callback_methods: ["POST"]]
    }
  ]

config :guardian, Guardian,
  issuer: "Watchnature",
  ttl: {30, :days},
  secret_key: "uw/27wdrIquPn2fktwfJg9tg8qOl5ysTPCFjISw1TCCaLlfWgRUAea1SuWcfERzX",
  serializer: WatchnatureWeb.GuardianSerializer,
  permissions: %{default: [:read, :write]}

config :arc,
  bucket: System.get_env("AWS_BUCKET_NAME"),
  asset_host: "https://#{System.get_env("AWS_BUCKET_NAME")}.s3.amazonaws.com"

config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
  region: System.get_env("AWS_REGION")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
