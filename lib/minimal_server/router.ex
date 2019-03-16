defmodule MinimalServer.Router do
  use Plug.Router

  require Logger

  plug(:match)
  plug(:dispatch)

  @json_content_type "application/json"

  get "/availableResults.json" do
    conn
    |> put_resp_content_type(@json_content_type)
    |> send_resp(200, json_message())
  end

  get "/leagues/:league_name/seasons/:season_period/results.json" do
    conn
    |> put_resp_content_type(@json_content_type)
    |> send_resp(200, json_message())
  end

  match _ do
    send_resp(conn, 404, "Requested resource does not exist")
  end

  defp json_message do
    Poison.encode!(%{
      response_type: "in_channel",
      text: "Hello from JSON BOT :)"})
  end
end
