defmodule Moz.BbCodes.TokenizerTest do
  use ExUnit.Case, async: true

  alias Moz.BbCodes.Tokenizer
  require Moz.BbCodes.BbToken
  alias Moz.BbCodes.BbToken

  describe "bb_codes" do
    test "should accept & parse text" do
      assert Tokenizer.call("") == {:ok, []}
      assert Tokenizer.call("a") == {:ok, [%BbToken{type: :text, value: "a", opts: %{}}]}
      assert Tokenizer.call("ab") == {:ok, [%BbToken{type: :text, value: "ab", opts: %{}}]}
      # special cases of text, not tokens.
      assert Tokenizer.call("[ ") == {:ok, [%BbToken{type: :text, value: "[ ", opts: %{}}]}
      assert Tokenizer.call("[ /") == {:ok, [%BbToken{type: :text, value: "[ /", opts: %{}}]}
      assert Tokenizer.call("[/ ") == {:ok, [%BbToken{type: :text, value: "[/ ", opts: %{}}]}
    end

    test "should parse closing [/b] token" do
      assert Tokenizer.call("[/b]") == {:ok, [%BbToken{type: :close, value: "b", opts: %{}}]}
    end

    test "should parse bold bbcode" do
      assert Tokenizer.call("[b]") == {:ok, [%BbToken{type: :open, value: "b", opts: %{}}]}
    end

    test "should parse sequence open, text and close bbcodes" do
      assert Tokenizer.call("[b]b[/b]") == {
        :ok,
        [
          %BbToken{type: :open, value: "b"},
          %BbToken{type: :text, value: "b"},
          %BbToken{type: :close, value: "b"}
        ]
      }
    end
  end
end
