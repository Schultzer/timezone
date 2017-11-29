defmodule Timezone.Request do
  @moduledoc false

  require Logger

  @doc false
  @spec fetch(String.t, String.t) :: {:ok, String.t} | {:error, String.t} | {:error, HTTPoison.Error.t} | {:error, :invalid} | {:error, {:invalid, String.t}}
  def fetch(lat, lng, api_key \\ Application.get_env(:timezone, :api_key))
  def fetch(_lat, _lng, nil), do: {:error, "Google Map Timezone API key is not configured."}
  def fetch(lat, lng, api_key) do
    case Application.get_env(:timezone, :base_api_url) do
      nil -> {:ok, nil}
      url ->  url <> "/maps/api/timezone/json"
              |> parse_from_url(location: lat <> "," <> lng, timestamp: :erlang.system_time(100), key: api_key)
    end
  end

  defp parse_from_url(url, params) do
    url
    |> HTTPoison.get([], params: params)
    |> handle_resp
    |> decode_json
    |> handle_result
  end

  defp handle_resp({:error, %HTTPoison.Error{reason: reason}}),
    do: {:error, reason}
  defp handle_resp({:ok, %HTTPoison.Response{status_code: 200, body: body}}),
    do: {:ok, body}
  defp handle_resp({:ok, %HTTPoison.Response{status_code: status_code, request_url: url}}),
    do: {:error, {status_code, url}}

  defp decode_json({:error, error}), do: {:error, error}
  defp decode_json({:ok, json}), do: Poison.decode(json)

  defp handle_result({:error, reason}) do
    Logger.error "Could not fetch Google Maps API because: #{inspect reason}"
    {:error, reason}
  end
  defp handle_result({:ok, data}) do
    data
    |> Map.get("timeZoneId")
    |> handle_result
  end
  defp handle_result(nil), do: {:error, "Could not fetch timezone"}
  defp handle_result(timezone), do: {:ok, timezone}

end
