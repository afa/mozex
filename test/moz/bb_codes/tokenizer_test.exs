defmodule Moz.BbCodes.TokenizerTest do
  use ExUnit.Case, async: true

  alias Moz.BbCodes.Tokenizer

  describe "bb_codes" do
    test "should parse bold bbcode" do
      assert Tokenizer.call("") == {:ok, {:text, []}}
      assert Tokenizer.call("[b]bold[/b]") == {:ok, [{:open, "b"}, {:text, "bold"}, {:close, "b"}]}
    end
  end
end
