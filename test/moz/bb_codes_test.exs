defmodule Moz.BbCodesTest do
  use ExUnit.Case, async: true

  alias Moz.BbCodes
  alias Moz.BbCodes.AstItem

  describe "bb_codes" do
    test "should parse empty" do
      assert [""] == BbCodes.call("")
    end

    test "should parse text" do
      text = BbCodes.call("text")
      assert ["text"] == text
    end

    test "error on mismatch token" do
      {:error, loc, msg} = BbCodes.call("[b]text")
      assert loc == {1, 7}
    end

    test "should parse bold" do
      assert ["", {:b, ["text"], []}, ""] == BbCodes.call("[b]text[/b]")
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
