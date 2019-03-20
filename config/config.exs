use Mix.Config

config :soccer_data_fetcher, SoccerDataFetcher.Endpoint, port: 4000

import_config "#{Mix.env()}.exs"
