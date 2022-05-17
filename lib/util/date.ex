defmodule Util.Date do
  @moduledoc """
  Date and DateTime helper functions.
  """
  @months [
    {1,  "Jan", "January"},
    {2,  "Feb", "February"},
    {3,  "Mar", "March"},
    {4,  "Apr", "April"},
    {5,  "May", "May"},
    {6,  "Jun", "June"},
    {7,  "Jul", "July"},
    {8,  "Aug", "August"},
    {9,  "Sep", "September"},
    {10, "Oct", "October"},
    {11, "Nov", "November"},
    {12, "Dec", "December"},
  ]

  @doc """
  Returns the day suffix for the given day integer.

      ## Examples

      ?> day_suffix(1)
      "st"

      ?> day_suffix(2)
      "nd"

  """
  def day_suffix(day) when day in 1..31 do
    cond do
      day in [1, 21, 31] -> "st"
      day in [2, 22] -> "nd"
      day in [3, 23] -> "rd"
      true -> "th"
    end
  end
  def day_suffix(day), do: raise "`#{day}` is not a valid day integer"

  @doc """
  Returns the month integer for the given month name.

      ## Examples

      ?> month_int("Feb")
      2

      ?> month_int("september")
      9

  """
  def month_int(month_str) when is_binary(month_str) do
    month_str = String.downcase(month_str)

    cond do
      String.starts_with?(month_str, "jan") -> 1
      String.starts_with?(month_str, "feb") -> 2
      String.starts_with?(month_str, "mar") -> 3
      String.starts_with?(month_str, "apr") -> 4
      String.starts_with?(month_str, "may") -> 5
      String.starts_with?(month_str, "jun") -> 6
      String.starts_with?(month_str, "jul") -> 7
      String.starts_with?(month_str, "aug") -> 8
      String.starts_with?(month_str, "sep") -> 9
      String.starts_with?(month_str, "oct") -> 10
      String.starts_with?(month_str, "nov") -> 11
      String.starts_with?(month_str, "dec") -> 12
    end
  end

  @doc """
  Returns the month name for the given month integer.

      ## Examples

      ?> month_name(1)
      "January"

      ?> month_name(9, :short)
      "Sep"

  """
  def month_name(month, opt \\ :short)
  def month_name(month, opt) when month in 1..12 do
    with {_num, short, long} <- List.keyfind(@months, month, 0) do
      case opt do
        :short -> short
        :long  -> long
      end
    end
  end
  def month_name(month, _opt), do: raise "`#{month}` is not a valid month integer"

end
