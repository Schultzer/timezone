defmodule Timezone.Parser do

  def request(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Code: 404 URL: #{url}"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def response({:ok, body}), do: body |> parse_json
  def response({:error, reason}), do: {:error, reason}

  def parse_json(json), do: json |> Poison.decode
  def parse_json!(json), do: json |> Poison.decode!
end
