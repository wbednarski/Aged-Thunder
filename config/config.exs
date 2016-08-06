# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :aged_thunder,
  ecto_repos: [AgedThunder.Repo]

# Configures the endpoint
config :aged_thunder, AgedThunder.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "HESoDJ21piisJ+QgfVFZz0a0tAGUUZRu0m3c57GBjVYLJ7lsUTPBu8vQFV/YcFJk",
  render_errors: [view: AgedThunder.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AgedThunder.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
