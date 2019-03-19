defmodule SoccerDataFetcher.RiakDataFetcher do
  @behaviour SoccerDataFetcher.DataFetcher

  def fetch_available_results do
    fetch_data('127.0.0.1', 8087, "soccer_results_bucket", "available_results")
  end

  def fetch_results_given_league_season(league, season) do
    fetch_data('127.0.0.1', 8087, "soccer_results_bucket", "results")
    |> Stream.filter(fn (x) ->
      Map.get(x, :div) == league and Map.get(x, :season) == season end)
    |> Enum.to_list    
  end

  defp fetch_data(host, port, bucket_name, key_name) do
    {:ok, pid} = :riakc_pb_socket.start_link(host, port)
    {:ok, riak_obj} = :riakc_pb_socket.get(pid, bucket_name, key_name)
    :riakc_obj.get_values(riak_obj)
    |> hd
    |> :erlang.binary_to_term
  end
end
