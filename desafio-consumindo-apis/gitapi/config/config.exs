# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gitapi,
  ecto_repos: [Gitapi.Repo]

config :tesla, adapter: Tesla.Adapter.Hackney

# Configures the endpoint
config :gitapi, GitapiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Z92JB6tjZ7Al8nU0FATRb0ZKHCb49Gdz6yDb7QIH5OCXLCPMiFKb/ZsAlFKoe3bd",
  render_errors: [view: GitapiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Gitapi.PubSub,
  live_view: [signing_salt: "60cHPjtp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
