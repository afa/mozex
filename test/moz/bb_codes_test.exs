defmodule Moz.BbCodesTest do
  use ExUnit.Case, async: true

  alias Moz.BbCodes
  alias Moz.BbCodes.AstItem

  describe "bb_codes" do
    test "should parse bold bbcode" do
      assert BbCodes.call("[b]bold[/b]") == []
    end

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
