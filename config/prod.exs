use Mix.Config

config :minimal_server, MinimalServer.Endpoint,
  port: String.to_integer(System.get_env("PORT") || "4444")
