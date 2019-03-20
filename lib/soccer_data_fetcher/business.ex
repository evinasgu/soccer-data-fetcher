defmodule SoccerDataFetcher.Business do
  @moduledoc """
  This module must contains the necessary business transformations over the data business flow
  """

  require Logger

  @doc """
  This function is working like a pass-through for the data_fetcher function. I added it
  because I consider a good practice to include the call to the data fetcher even if we
  are not making transformations in this layer.
  """
  def present_results_given_league_season(data_fetcher_function, league, season) do
    data_fetcher_function.(league, season)
  end

  @doc """
  This function take the data from the database and select the different types of result
  that can be presented in the api
  """
  def present_available_results(data_fetcher_function) do
    data_fetcher_function.()
    |> Stream.map(fn item -> decorate_available_result(item) end)
    |> Enum.to_list
  end

  @doc """
  This function takes the results saved in the database and transforms the season and the league
  into values more understandable to the consumers of the API
  """
  defp decorate_available_result(map_item) do
    leagues_map = %{"SP1" => "La Liga",
		    "SP2" => "La Liga Segunda Division",
		    "E0" => "Premier League",
		    "D1" => "Bundesliga 1"}
    decorated_map = map_item
    |> Map.replace(:div, Map.get(leagues_map, Map.get(map_item, :div)))
    |> Map.replace(:season, transform_season(Map.get(map_item, :season)))
    Map.get(decorated_map, :div) <> " " <> Map.get(decorated_map, :season)
  end

  @doc """
  This function takes the season from database and transform the values to a format more
  user friendly
  """
  defp transform_season(season) do
    {first_year, second_year} = {String.slice(season, 0..3), "20" <> String.slice(season, 4..6)}
    first_year <> "-" <> second_year
  end
end  
