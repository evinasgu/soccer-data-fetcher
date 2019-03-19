use Mix.Config

config :soccer_data_fetcher, SoccerDataFetcher.Endpoint,
  port: String.to_integer(System.get_env("PORT") || "4444")
