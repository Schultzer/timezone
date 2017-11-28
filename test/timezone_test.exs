defmodule TimezoneTest do
  use ExUnit.Case
  doctest Timezone

  describe "lookup/2" do
    test "with valid params" do
      expected = {:ok, "Asia/Bangkok"}
      assert expected == Timezone.lookup(13.739626, 100.560907)
      assert expected == Timezone.lookup("13.739626", "100.560907")
      assert expected == Timezone.lookup(Decimal.new(13.739626), Decimal.new("100.560907"))
      assert expected == Timezone.lookup(Decimal.new("13.739626"), Decimal.new(100.560907))
    end
    test "with invalid params" do
      assert {:error, "Unkownen latitude or longtitude error [] []"} == Timezone.lookup([], [])
    end
  end

  describe "lookup!/2" do
    test "with valid params" do
      expected = "Asia/Bangkok"
      assert expected == Timezone.lookup!(13.739626, 100.560907)
      assert expected == Timezone.lookup!("13.739626", "100.560907")
      assert expected == Timezone.lookup!(Decimal.new(13.739626), Decimal.new("100.560907"))
      assert expected == Timezone.lookup!(Decimal.new("13.739626"), Decimal.new(100.560907))
    end
    test "with invalid params" do
      assert_raise RuntimeError,  "Unkownen latitude or longtitude error [] []", fn ->
        Timezone.lookup!([], [])
      end
    end
  end

end
