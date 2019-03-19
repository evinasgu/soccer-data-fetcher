defmodule SoccerDataFetcher.ValidationTest do
  use ExUnit.Case
  doctest SoccerDataFetcher.Validation

  test "a valid request passes" do
    expected_result =  {:ok, "Request passed validations"}
    actual_result = SoccerDataFetcher.Validation.validate_result_request({"some_league", "some_season"})
    assert expected_result == actual_result
  end

  test "no valid request" do
    expected_result = {:error, "Non valid request"}
    actual_result = SoccerDataFetcher.Validation.validate_result_request({"", "some_season"})
    assert expected_result == actual_result
  end
end

  
