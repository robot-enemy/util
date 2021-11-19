defmodule Util.String do
  @moduledoc """
  Functions for string manipulations.
  """
  defmodule Truncation do
    @moduledoc false
    defstruct [
      :char_length,
      :limit,
      :source,
      :suffix,
      :truncated,
    ]
  end

  @doc """
  Moves 'The ', 'A ', or 'An ' to the end of the string.
  """
  @spec move_definite_article_to_end_of_string(nil | binary()) ::
          binary()

  def move_definite_article_to_end_of_string(nil), do: nil
  def move_definite_article_to_end_of_string(str) do
    [first_word | rest] = String.split(str, " ")
    not_the_only_word? = rest != []
    first_word_is_definite_article? = String.downcase(first_word) in ["the", "a", "an"]

    if not_the_only_word? && first_word_is_definite_article? do
      rest
      |> Enum.intersperse(" ")
      |> List.insert_at(-1, [", ", first_word])
      |> Enum.join("")
    else
      str
    end
  end

  @doc """
  Attempts to smartly truncate a string, separating it at a word boundary, and
  also taking into account the `read more` text, if it's needed.
  """
  @spec smart_truncate(str :: binary() | nil, limit :: integer(), suffix :: binary()) ::
          __MODULE__.Truncation.t()

  def smart_truncate(str, limit, suffix \\ " ...")
  def smart_truncate(nil, limit, suffix) do
    %Truncation{
      char_length: 0,
      limit: limit,
      source: nil,
      suffix: suffix,
      truncated: nil
    }
  end
  def smart_truncate(str, limit, suffix) when is_binary(str) do
    str_length    = String.length(str)
    truncated =
      if str_length <= limit do
        str
      else
        suffix_length = String.length(suffix)
        words         = String.split(str, " ")
        do_truncate(words, limit - suffix_length, "")
      end

    %Truncation{
      char_length: String.length(str),
      limit: limit,
      source: str,
      suffix: suffix,
      truncated: truncated,
    }
  end

  defp do_truncate([word|words], limit, acc) do
    str = String.trim(acc <> " " <> word)
    str = if String.ends_with?(str, "."), do: str <> " ", else: str

    if String.length(str) <= limit do
      do_truncate(words, limit, str)
    else
      acc
    end
  end
end
