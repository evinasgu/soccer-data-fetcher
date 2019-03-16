defmodule MinimalServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :minimal_server,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {MinimalServer.Application, []}
    ]
  end

  defp deps do
    [
      {:poison, "~> 4.0.1"},
      {:plug, "~> 1.7.2"},
      {:cowboy, "~> 2.6.1"},
      {:credo, "~> 1.0.3", except: :prod, runtime: false},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
