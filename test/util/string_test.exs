defmodule Util.StringTest do
  @moduledoc false
  use ExUnit.Case
  import Util.String, only: [
    move_definite_article_to_end_of_string: 1,
    smart_truncate: 2,
    smart_truncate: 3,
  ]

  describe "move_definite_article_to_end_of_string/1" do

    test "moves a definite article to the end of the string" do
      assert move_definite_article_to_end_of_string("The Lord of the Rings")
              == "Lord of the Rings, The"

      assert move_definite_article_to_end_of_string("A Game of Thrones")
              == "Game of Thrones, A"

      assert move_definite_article_to_end_of_string("An American Tragedy")
              == "American Tragedy, An"
    end

    test "does not move first word if not a definite article" do
      for str <- ["Harry Potter", "Animal Farm", "Angels & Demons"] do
        assert move_definite_article_to_end_of_string(str) == str
      end
    end

    test "does not change the string if the definite article is the only word" do
      for str <- ["The", "A", "An"] do
        assert move_definite_article_to_end_of_string(str) == str
      end
    end

    test "returns nil if the str is nil" do
      assert move_definite_article_to_end_of_string(nil) |> is_nil()
    end

  end

  describe "smart_truncate/3" do

    test "when passed nil, returns an empty Truncation struct" do
      assert %Util.String.Truncation{
        char_length: 0,
        limit: 10,
        source: nil,
        suffix: " > ",
        truncated: nil,
      } = smart_truncate(nil, 10, " > ")
    end

    test "do not truncate when string is equal to the limit" do
      ten_chars = "Abcdefghij"
      limit = 10

      assert %Util.String.Truncation{
        char_length: 10,
        limit: ^limit,
        source: ^ten_chars,
        suffix: " ...",
        truncated: ^ten_chars,
      } = smart_truncate(ten_chars, limit)
    end

    test "do not truncate when string is less than the limit" do
      ten_chars = "Abcdefghij"
      limit = 25

      assert %Util.String.Truncation{
        char_length: 10,
        limit: ^limit,
        source: ^ten_chars,
        suffix: " ...",
        truncated: ^ten_chars,
      } = smart_truncate(ten_chars, limit)
    end

    test "truncates when string is longer than limit" do
      thirty_chars = "abc efgh ijklmn opqrs tuvw xyz"
      limit = 25

      assert %Util.String.Truncation{
        char_length: 30,
        limit: ^limit,
        source: ^thirty_chars,
        suffix: " ...",
        truncated: "abc efgh ijklmn opqrs"
      } = smart_truncate(thirty_chars, limit)
    end

  end

end
