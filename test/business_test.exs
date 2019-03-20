defmodule SoccerDataFetcher.BusinessTest do
  import Mox

  use ExUnit.Case
  doctest SoccerDataFetcher.Business

  require Logger

  setup :verify_on_exit!

  test "present results given league and season with data" do
    mock_data = [
      %{
	season: "201516",
	id: "381",
	htr: "D",
	hthg: "0",
	htag: "0",
	home_team: "Malaga",
	ftr: "D",
	fthg: "0",
	ftag: "0",
	div: "SP1",
	date: "21/08/2015",
	away_team: "Sevilla"},
      %{
	season: "201516",
	id: "382",
	htr: "H",
	hthg: "1",
	htag: "0",
	home_team: "Ath Madrid",
	ftr: "H",
	fthg: "1",
	ftag: "0",
	div: "SP1",
	date: "21/08/2015",
	away_team: "Las Palmas"}]      

    SoccerDataFetcher.RiakDataFetcherMock
    |> expect(:fetch_results_given_league_season, fn league, season ->
      if league != "SP1" or season != "201516" do
	[]
      else
	mock_data
      end
    end)

    riak_fetch_results = fn x,y -> SoccerDataFetcher.RiakDataFetcherMock.fetch_results_given_league_season(x, y) end

    assert SoccerDataFetcher.Business.present_results_given_league_season(riak_fetch_results, "SP1", "201516") == mock_data
  end

  test "present available results in proper way" do
    mock_data = [
      %{
	season: "201516",
	id: "381",
	htr: "D",
	hthg: "0",
	htag: "0",
	home_team: "Malaga",
	ftr: "D",
	fthg: "0",
	ftag: "0",
	div: "SP1",
	date: "21/08/2015",
	away_team: "Sevilla"},
      %{
	season: "201516",
	id: "382",
	htr: "H",
	hthg: "1",
	htag: "0",
	home_team: "Ath Madrid",
	ftr: "H",
	fthg: "1",
	ftag: "0",
	div: "E0",
	date: "21/08/2015",
	away_team: "Las Palmas"}]      

    SoccerDataFetcher.RiakDataFetcherMock
    |> expect(:fetch_available_results, fn ->
      mock_data
    end)

    riak_fetch_available_results = fn -> SoccerDataFetcher.RiakDataFetcherMock.fetch_available_results end

    actual_result = SoccerDataFetcher.Business.present_available_results(riak_fetch_available_results)

    assert actual_result == ["La Liga 2015-2016", "Premier League 2015-2016"]
  end

end
