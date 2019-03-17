defmodule MinimalServer.Business do

  alias MinimalServer.RiakDataFetcher

  require Logger

  def present_results_given_league_season(league, season) do
    RiakDataFetcher.fetch_results_given_league_season(league, season)
    |> Poison.encode!
  end

  def present_available_results do
    RiakDataFetcher.fetch_available_results
    |> Stream.map(fn item -> decorate_available_result(item) end)
    |> Enum.to_list
    |> Poison.encode!
  end

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

  defp transform_season(season) do
    {first_year, second_year} = {String.slice(season, 0..3), "20" <> String.slice(season, 4..6)}
    first_year <> "-" <> second_year
  end
end  
