defmodule MinimalServer.Router do
  use Plug.Router

  alias MinimalServer.Business

  require Logger

  plug(:match)
  plug(:dispatch)

  @json_content_type "application/json"

  get "/availableResults.json" do
    Logger.info(Business.present_available_results)
    conn
    |> put_resp_content_type(@json_content_type)
    |> send_resp(200, Business.present_available_results)
  end

  get "/leagues/:league_name/seasons/:season_period/results.json" do
    conn
    |> put_resp_content_type(@json_content_type)
    |> send_resp(200, Business.present_results_given_league_season(league_name, season_period))
  end

  match _ do
    send_resp(conn, 404, "Requested resource does not exist")
  end
end
