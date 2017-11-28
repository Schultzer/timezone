defmodule Timezone do
  @moduledoc """
  Simple wrapper around Google Map Timezone API
  """

  @doc """
  Lookup a timezone id for the given latitude and longtitude.
  Returns `{:ok, result}` or `{:error, reason}`

  ## Example

      => Timezone.lookup(13.739626, 100.560907)
      {:ok, "Asia/Bangkok"}

      => Timezone.lookup("13.739626", "100.560907")
      {:ok, "Asia/Bangkok"}

      => Timezone.lookup(Decimal.new(13.739626), Decimal.new("100.560907"))
      {:ok, "Asia/Bangkok"}
  """
  @spec lookup(number | String.t | Decimal.t, number | String.t | Decimal.t) :: {:ok, String.t} | {:error, String.t} | {:error, HTTPoison.Error.t}
  def lookup(lat, lng)
  if Code.ensure_compiled?(Decimal) do
    def lookup(%Decimal{} = lat, %Decimal{} = lng) do
      lat
      |> Decimal.to_string
      |> Timezone.Request.fetch(Decimal.to_string(lng))
    end
  end

  def lookup(lat, lng) when is_number(lat) and is_number(lng) do
    lat
    |> Kernel.to_string
    |> Timezone.Request.fetch(Kernel.to_string(lng))
  end
  def lookup(lat, lng) when is_binary(lat) and is_binary(lng) do
    Timezone.Request.fetch(lat, lng)
  end
  def lookup(lat, lng), do: {:error, "Unkownen latitude or longtitude error #{inspect lat} #{inspect lng}"}


  @doc """
  The same as `lookup/2`, but raises an error if it fails.

  ## Example

      => Timezone.lookup!(13.739626, 100.560907)
      "Asia/Bangkok"

      => Timezone.lookup!("13.739626", "100.560907")
      "Asia/Bangkok"

      => Timezone.lookup(Decimal.new(13.739626), Decimal.new("100.560907"))
      "Asia/Bangkok"
  """
  @spec lookup!(number | String.t | Decimal.t, number | String.t | Decimal.t) :: String.t | HTTPoison.Error.t
  def lookup!(lat, lng) do
    case lookup(lat, lng) do
      {:error, reason} -> raise reason
      {:ok, result} -> result
    end
  end
end
