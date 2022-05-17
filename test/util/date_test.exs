defmodule Util.DateTest do
  @moduledoc false
  use ExUnit.Case
  import Util.Date
  doctest Util.Date

  describe "day_suffix/1" do

    test "given a valid day integer, returns a day with suffix string" do
      assert day_suffix(1) == "st"
      assert day_suffix(2) == "nd"
      assert day_suffix(3) == "rd"
      assert day_suffix(4) == "th"
      assert day_suffix(5) == "th"
      assert day_suffix(6) == "th"
      assert day_suffix(7) == "th"
      assert day_suffix(8) == "th"
      assert day_suffix(9) == "th"
      assert day_suffix(10) == "th"
      assert day_suffix(11) == "th"
      assert day_suffix(12) == "th"
      assert day_suffix(13) == "th"
      assert day_suffix(14) == "th"
      assert day_suffix(15) == "th"
      assert day_suffix(16) == "th"
      assert day_suffix(17) == "th"
      assert day_suffix(18) == "th"
      assert day_suffix(19) == "th"
      assert day_suffix(20) == "th"
      assert day_suffix(21) == "st"
      assert day_suffix(22) == "nd"
      assert day_suffix(23) == "rd"
      assert day_suffix(24) == "th"
      assert day_suffix(25) == "th"
      assert day_suffix(26) == "th"
      assert day_suffix(27) == "th"
      assert day_suffix(28) == "th"
      assert day_suffix(29) == "th"
      assert day_suffix(30) == "th"
      assert day_suffix(31) == "st"
    end

    test "raises error if not a valid day number" do
      assert_raise RuntimeError, fn -> day_suffix(0) end
      assert_raise RuntimeError, fn -> day_suffix(32) end
    end

  end

  describe "month_int/1" do

    test "given a valid month name, returns the integer for the month" do
      assert month_int("Jan") == 1
      assert month_int("Feb") == 2
      assert month_int("MAR") == 3
      assert month_int("APR") == 4
      assert month_int("May") == 5
      assert month_int("Jun") == 6
      assert month_int("jul") == 7
      assert month_int("aug") == 8
      assert month_int("Sep") == 9
      assert month_int("Oct") == 10
      assert month_int("Nov") == 11
      assert month_int("Dec") == 12
      assert month_int("January") == 1
      assert month_int("February") == 2
      assert month_int("March") == 3
      assert month_int("April") == 4
      assert month_int("MAY") == 5
      assert month_int("JUNE") == 6
      assert month_int("JULY") == 7
      assert month_int("AUGUST") == 8
      assert month_int("september") == 9
      assert month_int("october") == 10
      assert month_int("november") == 11
      assert month_int("december") == 12
    end

  end

  describe "month_name/2" do

    test "given a valid month integer, returns the short month name" do
      assert month_name(1) == "Jan"
      assert month_name(2) == "Feb"
      assert month_name(3) == "Mar"
      assert month_name(4) == "Apr"
      assert month_name(5) == "May"
      assert month_name(6) == "Jun"
      assert month_name(7) == "Jul"
      assert month_name(8) == "Aug"
      assert month_name(9) == "Sep"
      assert month_name(10) == "Oct"
      assert month_name(11) == "Nov"
      assert month_name(12) == "Dec"

      assert month_name(1, :short) == "Jan"
      assert month_name(2, :short) == "Feb"
      assert month_name(3, :short) == "Mar"
      assert month_name(4, :short) == "Apr"
      assert month_name(5, :short) == "May"
      assert month_name(6, :short) == "Jun"
      assert month_name(7, :short) == "Jul"
      assert month_name(8, :short) == "Aug"
      assert month_name(9, :short) == "Sep"
      assert month_name(10, :short) == "Oct"
      assert month_name(11, :short) == "Nov"
      assert month_name(12, :short) == "Dec"
    end

    test "given a valid month integer, returns the long month name" do
      assert month_name(1, :long) == "January"
      assert month_name(2, :long) == "February"
      assert month_name(3, :long) == "March"
      assert month_name(4, :long) == "April"
      assert month_name(5, :long) == "May"
      assert month_name(6, :long) == "June"
      assert month_name(7, :long) == "July"
      assert month_name(8, :long) == "August"
      assert month_name(9, :long) == "September"
      assert month_name(10, :long) == "October"
      assert month_name(11, :long) == "November"
      assert month_name(12, :long) == "December"
    end

    test "raises error if the month is not valid" do
      assert_raise RuntimeError, fn -> month_name(0) end
      assert_raise RuntimeError, fn -> month_name(13) end
    end
  end
end
