defmodule Util.RegexTest do
  @moduledoc false
  use ExUnit.Case
  import Util.Regex, only: [
    date_iso8601_regex: 1,
    uuid_v4_regex: 0
  ]
  import Util.UUID, only: [generate_v4_uuid: 0]

  describe "date_iso8601_regex/1" do

    test "returns a working iso8601 date regex" do
      assert %Regex{} = regex = date_iso8601_regex(:elixir)

      assert Regex.match?(regex, "2001-01-01")
      assert Regex.match?(regex, "1996-12-30")
      assert Regex.match?(regex, "1066-07-13")

      refute Regex.match?(regex, "2021-02-31")
      refute Regex.match?(regex, "21-01-01")
    end

    test "returns a raw regex when passed :raw" do
      date_regex = date_iso8601_regex(:raw)
      assert date_regex |> is_binary()
      assert String.starts_with?(date_regex, "^(?:[1-9]")
    end
  end

  describe "uuid_v4_regex/0" do

    test "returns a working UUID regex" do
      assert %Regex{} = regex = uuid_v4_regex()

      Enum.each(1..10, fn _ ->
        uuid = generate_v4_uuid()
        assert Regex.match?(regex, uuid)
      end)

      refute Regex.match?(regex, "1234567890")
    end
  end

end
