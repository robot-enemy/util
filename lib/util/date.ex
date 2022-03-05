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

  def day_suffix(day) when day in 1..31 do
    cond do
      day in [1, 21, 31] -> "st"
      day in [2, 22] -> "nd"
      day in [3, 23] -> "rd"
      true -> "th"
    end
  end
  def day_suffix(day), do: raise "`#{day}` is not a valid day integer"

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
