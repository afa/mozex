defmodule Moz.BbCodesTest do
  use ExUnit.Case, async: true

  alias Moz.BbCodes

  describe "bb_codes" do
    test "should parse bold bbcode" do
      assert Moz.BbCodes.call("[b]bold[/b]") == []
    end

    # test "should parse italic bbcode" do
    #   assert Moz.BbCodes.call("[i]italic[/i]") == []
    # end

    # test "should parse underline bbcode" do
    #   assert Moz.BbCodes.call("[u]underline[/u]") == []
    # end

    # test "should parse strikethrough bbcode" do
    #   assert Moz.BbCodes.call("[s]strikethrough[/s]") == []
    # end
  end
end
