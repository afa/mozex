defmodule Moz.BbCodesTest do
  use ExUnit.Case, async: true

  alias Moz.BbCodes
  alias Moz.BbCodes.AstItem

  describe "bb_codes" do
    test "should parse empty" do
      assert {:ok, []} == BbCodes.call("")
    end

    test "should parse text" do
      {:ok, text} = BbCodes.call("text")
      assert "text" == to_string(text)
    end

    test "should parse bold" do
      [%{type: type, value: value} | tail] = BbCodes.call("[b]text")
      IO.inspect(type, value, tail)
      assert type == :text
      assert value == "text"
    end

    # test "should parse bold bbcode" do
    #   BbCodes.call("[b]bold[/b]") |> IO.inspect()
    #   assert BbCodes.call("[b]bold[/b]") == []
    # end

    # test "should parse italic bbcode" do
    #   assert BbCodes.call("[i]italic[/i]") == []
    # end

    # test "should parse underline bbcode" do
    #   assert BbCodes.call("[u]underline[/u]") == []
    # end

    # test "should parse strikethrough bbcode" do
    #   assert BbCodes.call("[s]strikethrough[/s]") == []
    # end
  end
end
