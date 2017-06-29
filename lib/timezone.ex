defmodule Timezone do
  def lookup(opts) do
    opts
    |> build_params
    |> build_url
    |> Timezone.Parser.request
    |> Timezone.Parser.response
  end
  def lookup(lat, lng), do: %{lat: lat, lng: lng} |> lookup()
  def lookup(%{lat: lat, lng: lng}), do: %{lat: lat, lng: lng} |> lookup()
  def lookup!(lat, lng), do: lookup(lat, lng) |> extrat_timezone
  def lookup!(opts), do: lookup(opts) |> extrat_timezone


  def extrat_timezone({:ok, %{"dstOffset" => _, "rawOffset" => _, "status" => _,
                              "timeZoneId" => timezone, "timeZoneName" => _}}), do: timezone
  def extrat_timezone({:ok, map}), do: raise ArgumentError, "Whooops something went wrong! #{map}"
  def extrat_timezone({:error, reason}), do: raise ArgumentError, reason

  def build_params(%{lat: lat, lng: lng}) do
    cond do
      is_float(lat) -> %{lat: Float.to_string(lat), lng: lng} |> build_params
      is_float(lng) -> %{lat: lat, lng: Float.to_string(lng)} |> build_params
      true          -> %{lat: lat, lng: lng}
    end
  end

  def build_url(opts) do
    base = "https://maps.googleapis.com/maps/api/timezone/json?location="
    now = :erlang.system_time(100)
    timestamp = "&timestamp=#{now}"
    api_key = "&key=#{Application.get_env(:timezone, :api_key)}"
    # api_key = "&key=AIzaSyAC98l_D9VwoNGPkrvJXU4nrHzfXawi4as"
    base <> opts.lat <> "," <> opts.lng <> timestamp <> api_key
  end
end
