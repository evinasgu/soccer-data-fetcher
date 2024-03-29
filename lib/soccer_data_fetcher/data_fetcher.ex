defmodule SoccerDataFetcher.DataFetcher do
  @callback fetch_available_results() :: {:ok, [Map.t]} | {:error, String.t}
  @callback fetch_results_given_league_season(String.t, String.t) :: {:ok, [Map.t]} | {:error, String.t}
end
