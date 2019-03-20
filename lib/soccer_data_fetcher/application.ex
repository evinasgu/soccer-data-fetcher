defmodule SoccerDataFetcher.Application do
  @moduledoc """
  This module has the responsibility of coordinate the lifecycle of the entire service
  """
  use Application

  alias SoccerDataFetcher.Endpoint
  alias SoccerDataFetcher.RiakDataLoader

  @doc """
  This function coordinates the executions of the processes at the start of the application
  """
  def start(_type, _args) do
    RiakDataLoader.load_all_rows()
    RiakDataLoader.load_available_results()
    Supervisor.start_link(children(), opts())
  end

  @doc """
  This function assign children to the actual supervisor service
  """
  defp children do
    [
      Endpoint
    ]
  end

  @doc """
  This function build the opts values to be charged at start of the application
  """
  defp opts do
    [
      strategy: :one_for_one,
      name: SoccerDataFetcher.Supervisor
    ]
  end
end
