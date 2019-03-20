defmodule SoccerDataFetcher.RiakDataFetcher do
  @moduledoc """
  This module has the responsibility of fetch the data from the Riak database
  """
  @behaviour SoccerDataFetcher.DataFetcher

  @doc """
  This function fetchs the data from Riak database
  """
  def fetch_available_results do
    fetch_data('172.18.0.2', 8087, "soccer_results_bucket", "available_results")
  end

  @doc """
  This function has the responsibility of filtering the data from Riak by league and 
  season values.
  """
  def fetch_results_given_league_season(league, season) do
    fetch_data('172.18.0.2', 8087, "soccer_results_bucket", "results")
    |> Stream.filter(fn (x) ->
      Map.get(x, :div) == league and Map.get(x, :season) == season end)
    |> Enum.to_list    
  end

  @doc """
  This private function get the data from Riak without any filtering process
  """
  defp fetch_data(host, port, bucket_name, key_name) do
    {:ok, pid} = :riakc_pb_socket.start_link(host, port)
    {:ok, riak_obj} = :riakc_pb_socket.get(pid, bucket_name, key_name)
    :riakc_obj.get_values(riak_obj)
    |> hd
    |> :erlang.binary_to_term
  end
end
