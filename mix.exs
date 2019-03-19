defmodule SoccerDataFetcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :soccer_data_fetcher,
      version: "0.1.0",
      elixir: "~> 1.8.1",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :nimble_csv],
      mod: {SoccerDataFetcher.Application, []}
    ]
  end

  defp deps do
    [
      {:poison, "~> 4.0.1"},
      {:plug, "~> 1.7.2"},
      {:cowboy, "~> 2.6.1"},
      {:credo, "~> 1.0.3", except: :prod, runtime: false},
      {:plug_cowboy, "~> 2.0.2"},
      {:nimble_csv, "~> 0.3"},
      {:riakc, github: "basho/riak-erlang-client"},
      {:protobuf, "~> 0.5.3"},
      {:google_protos, "~> 0.1"},
      {:distillery, "~> 2.0"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end
end
