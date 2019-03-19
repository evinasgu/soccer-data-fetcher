defmodule SoccerDataFetcher.Validation do

  def validate_result_request({league, season}) do
    case validate_item(league) && validate_item(season) do
      true -> {:ok, "Request passed validations"}
      _ -> {:error, "Non valid request"}
    end
  end

  defp validate_item(item) do
    item != nil and String.strip(item) != ""
  end
end
