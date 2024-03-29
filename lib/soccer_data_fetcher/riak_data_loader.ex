defmodule SoccerDataFetcher.RiakDataLoader do
  @moduledoc """
  This module has the responsibility of loading data from Data.csv file to Riak
  """

  @behaviour SoccerDataFetcher.DataLoader

  alias NimbleCSV.RFC4180

  require Logger

  @doc """
  This function loads all the rows from csv to Riak
  """
  def load_all_rows do
    read_csv_data("./resources/Data.csv")
    |> save_to_riak('172.18.0.2', 8087, "soccer_results_bucket", "results")
  end

  @doc """
  This function loads all the possible result types that can be fetch from the csv to Riak
  """
  def load_available_results() do
    read_csv_data("./resources/Data.csv")
    |> Stream.uniq_by(fn %{away_team: _, date: _, div: div, ftag:  _, fthg: _, ftr: _, home_team: _, htag: _, hthg: _, htr: _, id: _, season: season} -> {div, season} end)
    |> Enum.to_list()
    |> Enum.map(fn x -> %{div: Map.get(x, :div), season: Map.get(x, :season)} end)
    |> save_to_riak('172.18.0.2', 8087, "soccer_results_bucket", "available_results")
  end

  @doc """
  This function just read the data from the csv file and transform it to a map in order
  to be processed for the rest of the application
  """
  defp read_csv_data(path) do
    path
    |> File.stream!
    |> RFC4180.parse_stream
    |> Enum.map(fn [id,div,season,date,home_team,away_team,fthg,ftag,ftr,hthg,htag,htr] ->
      %{id: id, div: div, season: season, date: date, home_team: home_team, away_team: away_team, fthg: fthg, ftag: ftag, ftr: ftr, hthg: hthg, htag: htag, htr: htr}
    end)
  end

  @doc """
  This function takes the data processed and save it to a Riak KV instance 
  """
  defp save_to_riak(data, host, port, bucket_name, key_name) do
    Logger.info("Storing #{key_name} initial data in Riak KV...")
    {:ok, pid} = :riakc_pb_socket.start_link(host, port)
    riak_object = :riakc_obj.new(bucket_name, key_name, data)
    Logger.info("The data have been loaded succesfully")
    case :riakc_pb_socket.put(pid, riak_object) do
      {:ok, _} -> {:ok, "The data have been loaded succesfully"}
      _ -> {:error, "Error loading data to Riak"}    
    end
  end
  
end
