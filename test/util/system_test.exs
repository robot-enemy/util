defmodule Util.SystemTest do
  @moduledoc false
  use ExUnit.Case
  import Util.System, only: [command_installed?: 1]

  describe "command_installed?/1" do

    test "should return true if the command is installed on the system" do
      assert command_installed?("ls")
    end

    test "should return false if the command is not installed on the system" do
      refute command_installed?("dfgdfgdfg")
    end
  end

end
