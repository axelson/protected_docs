# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :protected_docs, ProtectedDocsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RvFD2gEUuCpBWGYUzv4jt10E40sOLFD5p+4ufvJVj32mvUh0a4G4LSN0dYnJqyQ7",
  render_errors: [view: ProtectedDocsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ProtectedDocs.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :oauth2,
  serializers: %{
    "application/vnd.api+json" => Poison
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
