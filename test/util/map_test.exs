defmodule Util.MapTest do
  @moduledoc false
  use ExUnit.Case
  import Util.Map, only: [
    convert_atom_keys_to_strings: 1,
    convert_string_keys_to_atoms: 1,
    sort_map_array: 3,
    sort_str_array: 2,
  ]

  describe "convert_atom_keys_to_strings/1" do

    test "should convert keys to strings when given a map with atom keys" do
      params = %{test: 1, other: 2}
      assert %{"test" => 1, "other" => 2} = convert_atom_keys_to_strings(params)
    end

    test "should only convert atom keys when given a map with mixed keys" do
      params = %{"test" => 1, other: 2}
      assert %{"test" => 1, "other" => 2} = convert_atom_keys_to_strings(params)
    end

    test "should also convert lists when given a map with lists of maps" do
      params = %{test: [%{one: 1}, %{two: 2}]}
      assert %{"test" => [%{"one" => 1}, %{"two" => 2}]} = convert_atom_keys_to_strings(params)
    end

  end

  describe "convert_string_keys_to_atoms/1" do

    test "should convert keys to atoms when given a map with string keys" do
      params = %{"test" => 1, "other" => 2}
      assert %{test: 1, other: 2} = convert_string_keys_to_atoms(params)
    end

    test "should only convert string keys when given a map with mixed keys" do
      params = %{"test" => 1, other: 2}
      assert %{test: 1, other: 2} = convert_string_keys_to_atoms(params)
    end

    test "should also convert lists when given a map with lists of maps" do
      params = %{"test" => [%{"one" => 1, "two" => 2}]}
      assert %{test: [%{one: 1, two: 2}]} = convert_string_keys_to_atoms(params)
    end

  end

  describe "sort_map_array/3" do

    test "should do nothing when passed no keys" do
      data_map = %{
        publishers: [%{name: "Three"}, %{name: "One"}]
      }
      assert data_map == sort_map_array(data_map, [], [])
    end

    test "should sort the requested field by the key given" do
      data_map = %{
        publishers: [%{name: "Three"}, %{name: "One"}]
      }

      assert sorted = sort_map_array(data_map, [:publishers], sort_by: :name)
      assert sorted.publishers == [%{name: "One"}, %{name: "Three"}]
    end

    test "should sort multiple fields when given multiple keys" do
      data_map = %{
        bets: [%{num: "2"}, %{num: "3"}, %{num: "1"}],
        nums: [%{num: 2}, %{num: 3}, %{num: 1}]
      }

      assert sorted = sort_map_array(data_map, [:nums, :bets], sort_by: :num)
      assert sorted.bets == [%{num: "1"}, %{num: "2"}, %{num: "3"}]
      assert sorted.nums == [%{num: 1}, %{num: 2}, %{num: 3}]
    end

    test "should ignores keys that don't exist" do
      data_map = %{
        publishers: [%{name: "Three"}, %{name: "One"}],
        series: [%{name: "Three"}, %{name: "One"}],
      }
      keys = [:publishers, :events]

      assert sorted = sort_map_array(data_map, keys, sort_by: :name)
      assert sorted.publishers == [%{name: "One"}, %{name: "Three"}]
      assert sorted.series == [%{name: "Three"}, %{name: "One"}]
    end

  end

  describe "sort_str_array/2" do

    test "should do nothing when given no keys" do
      data_map = %{publishers: ["Marvel", "DC"]}
      assert data_map == sort_str_array(data_map, [])
    end

    test "should sort the list of a given key" do
      data_map = %{publishers: ["Marvel", "DC"]}
      assert sorted = sort_str_array(data_map, [:publishers])
      assert sorted.publishers == ["DC", "Marvel"]
    end

    test "should sort the lists of multiple keys" do
      data_map = %{
        publishers: ["Marvel", "DC"],
        series: ["Superman", "Batman", "Green Lantern"]
      }
      assert sorted = sort_str_array(data_map, [:publishers, :series])
      assert sorted.publishers == ["DC", "Marvel"]
      assert sorted.series == ["Batman", "Green Lantern", "Superman"]
    end

    test "should ignore keys that don't exist" do
      data_map = %{
        publishers: ["Marvel", "DC"],
        series: ["Superman", "Batman", "Green Lantern"]
      }
      keys = [:publishers, :events]

      assert sorted = sort_str_array(data_map, keys)
      assert sorted.publishers == ["DC", "Marvel"]
      assert sorted.series == ["Superman", "Batman", "Green Lantern"]
    end
  end

end
