defmodule Watchnature.Mixfile do
  use Mix.Project

  def project do
    [app: :watchnature,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Watchnature, []},
     applications: [:phoenix,
                    :phoenix_pubsub,
                    :phoenix_html,
                    :cowboy,
                    :logger,
                    :gettext,
                    :phoenix_ecto,
                    :ueberauth,
                    :ueberauth_identity,
                    :comeonin,
                    :corsica,
                    :postgrex,
                    :ex_aws,
                    :hackney,
                    :poison,
                    :httpoison,
                    :timex,
                    :scrivener,
                    :scrivener_ecto,
                    :ex_machina,
                    :poison]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.3.0"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:mix_test_watch, "~> 0.3", only: :dev, runtime: false},
     {:gettext, "~> 0.11"},
     {:comeonin, "~> 2.3"},
     {:corsica, "~> 0.5"},
     {:ueberauth, "~> 0.2"},
     {:ueberauth_identity, "~> 0.2"},
     {:guardian, "~> 0.10"},
     {:bodyguard, "~> 2.0.0"},
     {:geo, "~> 1.4"},
     {:ecto_enum, "~> 1.0"},
     {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
     {:ex_aws, "~> 1.0"},
     {:poison, "~> 2.0"},
     {:hackney, "~> 1.6"},
     {:arc, "~> 0.8.0"},
     {:sweet_xml, "~> 0.6"},
     {:httpoison, "~> 0.12"},
     {:timex, "~> 3.1.0"},
     {:scrivener, "~> 2.0"},
     {:scrivener_ecto, "~> 1.0"},
     {:ex_machina, "~> 2.0", only: :test},
     {:cowboy, "~> 1.0"}]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"],
     "t": ["ecto.create --quiet", "ecto.migrate", "test.watch"],
     "s": ["phx.server"]]
  end
end
