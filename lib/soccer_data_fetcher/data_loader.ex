defmodule SoccerDataFetcher.DataLoader do
  @callback load_all_rows() :: {:ok, success_message :: term} | {:error, error_message :: term}
  @callback load_available_results() :: {:ok, success_message :: term} | {:error, error_message :: term}
end  
