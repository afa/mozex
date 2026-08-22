defmodule Moz.BbCodes.BuilderTest do
  use ExUnit.Case, async: true

  alias Moz.BbCodes.BbToken
  alias Moz.BbCodes.Builder
  alias Moz.BbCodes.AstItem

  describe "builder" do
    test "empty list" do
      assert Builder.call([]) == []
    end

    test "text list" do
      [%{type: :text, value: val} | tail] =
        Builder.call([%BbToken{type: :text, value: "a", opts: %{}}])

      assert val == "a"
    end
  end

  # describe "bb_codes" do
  #   test "should parse text" do
  #     [%{type: type, value: value} | tail] = BbCodes.call("text")
  #     assert type == :text
  #     assert value = "text"
  #   end

  #   test "should parse bold bbcode" do
  #     assert BbCodes.call("[b]bold[/b]") == []
  #   end
  # end
end
