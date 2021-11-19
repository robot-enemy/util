defmodule Util.Integer do
  @moduledoc false

  @doc """
  Takes an integer or string integer, and returns a boolean.
  """
  @spec convert_int_to_bool(binary() | integer()) ::
          boolean()

  def convert_int_to_bool("0"), do: false
  def convert_int_to_bool("1"), do: true
  def convert_int_to_bool(0), do: false
  def convert_int_to_bool(1), do: true

end
