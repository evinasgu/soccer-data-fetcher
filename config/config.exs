use Mix.Config

config :minimal_server, MinimalServer.Endpoint, port: 4000

import_config "#{Mix.env()}.exs"
