# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bomber,
  ecto_repos: [Bomber.Repo]

# Configures the endpoint
config :bomber, BomberWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "J+C1kRQ4Pdo5TxY8Zc87TaEEBWUnpb0P33vuzEa+ze8m/LTjSPdTGHZMrMnZy+TM",
  render_errors: [view: BomberWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bomber.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
