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
           adapter: Phoenix.PubSub.PG2],
  trello_key: System.get_env("TRELLO_KEY"),
  trello_token: System.get_env("TRELLO_TOKEN")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Attachment uploader arc and s3 config
config :arc,
  bucket: "aged-thunder",
  virtual_host: true

config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID_AGED_THUNDER"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY_AGED_THUNDER"}, :instance_role],
  s3: [
    scheme: "https://",
    host: "s3-us-west-2.amazonaws.com", #Oregon
    region: "us-west-2"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
