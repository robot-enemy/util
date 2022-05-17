defmodule Util.IntegerTest do
  @moduledoc false
  use ExUnit.Case
  import Util.Integer, only: [convert_int_to_bool: 1]

  describe "convert_int_to_bool/1" do

    test "should return true when given 1" do
      assert convert_int_to_bool(1)
      assert convert_int_to_bool("1")
    end

    test "should return false when given 0" do
      refute convert_int_to_bool(0)
      refute convert_int_to_bool("0")
    end

  end

end
