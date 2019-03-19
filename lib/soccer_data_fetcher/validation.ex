defmodule SoccerDataFetcher.Validation do
  @moduledoc """
  This module has the responsibility of validate the possible requests given to the service
  """

  @doc """
  This function validates a request from the results endpoint

  ## Examples

  iex> SoccerDataFetcher.Validation.validate_result_request({"some_league", "some_season"})
  {:ok, "Request passed validations"}

  iex> SoccerDataFetcher.Validation.validate_result_request({"", "some_season"})
  {:error, "Non valid request"}
  """
  def validate_result_request({league, season}) do
    case validate_item(league) && validate_item(season) do
      true -> {:ok, "Request passed validations"}
      _ -> {:error, "Non valid request"}
    end
  end

  @doc """
  This function constains the actual validation rule. It is just taking the validation for blank entry
  """
  defp validate_item(item) do
    item != nil and String.strip(item) != ""
  end
end
