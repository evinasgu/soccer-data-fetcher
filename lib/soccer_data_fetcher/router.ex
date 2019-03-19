defmodule SoccerDataFetcher.Router do
  use Plug.Router

  alias SoccerDataFetcher.Business

  alias SoccerDataFetcher.Validation

  require Logger

  plug(:match)
  plug(:dispatch)

  @json_content_type "application/json"
  @protobuf_content_type "application/x-protobuf"

  get "/availableResults.json" do
    conn
    |> put_resp_content_type(@json_content_type)
    |> send_resp(200, Poison.encode!(Business.present_available_results))
  end

  get "/leagues/:league_name/seasons/:season_period/results.json" do
    case Validation.validate_result_request({league_name, season_period}) do
      {:ok, _message} ->
	conn
	|> put_resp_content_type(@json_content_type)
	|> send_resp(200, Poison.encode!(Business.present_results_given_league_season(league_name, season_period)))
      {:error, _message} ->
	conn
	|> send_resp(400, "Bad Request")
    end
  end

  get "/availableResults.proto" do
    response = AvailableResults.new(resultType: Business.present_available_results)
    conn
    |> put_resp_content_type(@protobuf_content_type)
    |> send_resp(200, AvailableResults.encode(response))
  end

  get "/leagues/:league_name/seasons/:season_period/results.proto" do
    case Validation.validate_result_request({league_name, season_period}) do
      {:ok, _message} ->
	response = Business.present_results_given_league_season(league_name, season_period)
	|> Stream.map(fn item -> map_to_struct(item, as: %ResultItem{}) end)
	|> Enum.to_list    
	conn
	|> put_resp_content_type(@protobuf_content_type)
	|> send_resp(200, Result.encode(Result.new(Result: response)))
      {:error, _message} ->
	conn
	|> send_resp(400, "Bad Request")
    end
  end
  

  match _ do
    send_resp(conn, 404, "Requested resource does not exist")
  end

  defp map_to_struct(a_map, as: a_struct) do
    keys = Map.keys(a_struct) 
    |> Enum.filter(fn x -> x != :__struct__ end)
    processed_map =
    for key <- keys, into: %{} do
      value = Map.get(a_map, key) || Map.get(a_map, to_string(key))
      {key, value}
    end
    a_struct = Map.merge(a_struct, processed_map)
    a_struct
  end
end
