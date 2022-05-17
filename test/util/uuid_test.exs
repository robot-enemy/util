defmodule Util.UUIDTest do
  @moduledoc false
  use ExUnit.Case
  import Util.UUID, only: [
    generate_v4_uuid: 0
  ]

  describe "generate_v4_uuid/0" do

    test "should generate a valid v4 UUID" do
      uuid_regex = ~r/[\da-f]{8}-([\da-f]{4}-){3}[\da-f]{12}/i

      for _ <- 1..5 do
        assert Regex.match?(uuid_regex, generate_v4_uuid())
      end
    end
  end
end
