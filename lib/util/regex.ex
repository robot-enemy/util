defmodule Util.Regex do
  @moduledoc """
  Useful regular expressions.
  """

  # credo:disable-for-next-line Credo.Check.Readability.MaxLineLength
  @date_iso8601_regex "^(?:[1-9][0-9]{3}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[1-9][0-9](?:0[48]|[2468][048]|[13579][26])|(?:[2468][048]|[13579][26])00)-02-29)$"

  @doc """
  Matches dates in the iso8601 format, i.e. "2001-02-02" or "1886-12-02"
  """
  @spec date_iso8601_regex(atom()) :: Regex.t()

  def date_iso8601_regex(:elixir), do: Regex.compile!(@date_iso8601_regex)
  def date_iso8601_regex(:raw), do: @date_iso8601_regex

  @doc """
  Matches v4 UUIDs.
  """
  @spec uuid_v4_regex :: Regex.t()

  def uuid_v4_regex do
    ~r/^[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}$/i
  end
end
