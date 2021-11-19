defmodule Util.URL do
  @moduledoc """
  Tools for stripping params from URLs.
  """

  @utm_params [
    "utm_campaign",
    "utm_content",
    "utm_medium",
    "utm_source",
    "utm_term"
  ]

  @doc """
  Removes UTM query parameters from a URL, can optionally include a list of
  params to remove.

  ## Examples

      iex> strip_utm_params("https://www.example.com?utm_medium=web")
      "https://www.example.com"

      iex> strip_utm_params("https://www.example.com?test=test&utm_source=email")
      "https://www.example.com?test=test"

      iex> strip_url_params("https://www.example.com?a=1&b=2&c=3", ["b"])
      "https://www.example.com?a=1&c=3"

  """
  @spec strip_url_params(String.t(), list(String.t)) :: String.t()

  def strip_url_params(url, params_to_remove \\ @utm_params) do
    parsed_uri = URI.parse(url)
    query = remove_parameters(parsed_uri.query, params_to_remove)

    %URI{ parsed_uri | query: query }
    |> URI.to_string
  end

  defp remove_parameters(nil, _), do: nil
  defp remove_parameters(query, params_to_remove) do
    query =
      query                         # "one=1&utm_term=h"
      |> URI.decode_query           # %{one: 1, utm_term: h}
      |> Map.drop(params_to_remove) # %{one: 1}
      |> URI.encode_query           # "one=1"

    if query == "", do: nil, else: query
  end

  @doc """
  Returns the list of current UTM parameters to strip.
  """
  @spec utm_params :: List.t()

  def utm_params, do: @utm_params

end
