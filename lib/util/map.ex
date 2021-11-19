defmodule Util.Map do
  @moduledoc false

  @doc """
  Takes a map and convert atom keys to strings.
  """
  @spec convert_atom_keys_to_strings(map()) ::
          map()

  def convert_atom_keys_to_strings(target) when is_map(target) do
    for {key, val} <- target, into: %{} do
      if is_atom(key) do
        {Atom.to_string(key), convert_atom_keys_to_strings(val)}
      else
        {key, convert_atom_keys_to_strings(val)}
      end
    end
  end
  def convert_atom_keys_to_strings(target) when is_list(target) do
    for item <- target, do: convert_atom_keys_to_strings(item)
  end
  def convert_atom_keys_to_strings(target), do: target

  @doc """
  Takes a map and converts string keys to atoms.
  """
  @spec convert_string_keys_to_atoms(map()) ::
          map()

  def convert_string_keys_to_atoms(target) when is_map(target) do
    for {key, val} <- target, into: %{} do
      if is_atom(key) do
        {key, convert_string_keys_to_atoms(val)}
      else
        {String.to_atom(key), convert_string_keys_to_atoms(val)}
      end
    end
  end
  def convert_string_keys_to_atoms(target) when is_list(target) do
    for item <- target, do: convert_string_keys_to_atoms(item)
  end
  def convert_string_keys_to_atoms(target), do: target

  @doc """
  Takes a map, a list of keys and an option list.  The keys should point to
  fields that are a list of maps, which it will then attempt to sort.
  """
  @spec sort_map_array(data_map :: map(), keys :: list(), opts :: list()) ::
          map()

  def sort_map_array(data_map, [], _), do: data_map
  def sort_map_array(data_map, [key|keys], sort_by: field) do
    if list = Map.get(data_map, key) do
      sorted_by_field = Enum.sort_by(list, &(&1[field]))
      data_map |> Map.put(key, sorted_by_field) |> sort_map_array(keys, sort_by: field)
    else
      sort_map_array(data_map, keys, sort_by: field)
    end
  end

  @doc """
  Takes a map and a list of keys.  If the key exists on the map, and is a list
  of strings, it will sort them.
  """
  @spec sort_str_array(data_map :: map(), keys :: list()) ::
          map()

  def sort_str_array(data_map, []), do: data_map
  def sort_str_array(data_map, [key|keys]) do
    if list = Map.get(data_map, key) do
      data_map |> Map.put(key, Enum.sort(list)) |> sort_str_array(keys)
    else
      sort_str_array(data_map, keys)
    end
  end

end
