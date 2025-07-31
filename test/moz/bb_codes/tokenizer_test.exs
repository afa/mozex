defmodule Moz.BbCodes.TokenizerTest do
  use ExUnit.Case, async: true

  alias Moz.BbCodes.Tokenizer
  require Moz.BbCodes.BbToken
  alias Moz.BbCodes.BbToken

  describe "bb_codes" do
    test "should parse bold bbcode" do
      assert Tokenizer.call("") == {:ok, [%BbToken{type: :text, value: "", opts: %{}}]}
      assert Tokenizer.call("a") == {:ok, [%BbToken{type: :text, value: "a", opts: %{}}]}
      assert Tokenizer.call("ab") == {:ok, [%BbToken{type: :text, value: "ab", opts: %{}}]}
      assert Tokenizer.call("[b]") == {:ok, [%BbToken{type: :token, value: "b", opts: %{}}]}
      # assert Tokenizer.call("[b]bold[/b]") == {:ok, [{:open, "b"}, {:text, "bold"}, {:close, "b"}]}
    end
  end
end
