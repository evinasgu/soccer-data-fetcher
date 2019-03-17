defmodule MinimalServer.Application do
  use Application

  alias MinimalServer.Endpoint
  alias MinimalServer.RiakDataLoader

  def start(_type, _args) do
    RiakDataLoader.load_all_rows()
    RiakDataLoader.load_available_results()
    Supervisor.start_link(children(), opts())
  end

  defp children do
    [
      Endpoint
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: MinimalServer.Supervisor
    ]
  end
end
