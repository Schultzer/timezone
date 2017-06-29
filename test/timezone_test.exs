defmodule TimezoneTest do
  use ExUnit.Case
  doctest Timezone

  import Timezone

  test "lookup/1 returns {status, map}" do
    expected = "Asia/Bangkok"
    {:ok, result} = Timezone.lookup(13.739626, 100.560907)
    assert expected == result["timeZoneId"]
  end

  test "lookup!/1 returns timezone" do
    expect = "Asia/Bangkok"
    result = Timezone.lookup!(13.739626, 100.560907)
    assert expect == result
  end

end
