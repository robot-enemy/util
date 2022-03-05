defmodule Util.DateTest do
  @moduledoc false
  use ExUnit.Case
  import Util.Date

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
