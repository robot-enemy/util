defmodule Util.System do
  @moduledoc """
  Utility functions for interacting with the system.
  """

  @doc """
  Ask the system if the given command is installed.
  """
  @spec command_installed?(command :: binary()) ::
          boolean()

  def command_installed?(command) do
    case System.cmd("type", [command], [stderr_to_stdout: true]) do
      {_, 0} -> true
      {_, 1} -> false
    end
  end

end
