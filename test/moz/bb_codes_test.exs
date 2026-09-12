defmodule Moz.BbCodesTest do
  use ExUnit.Case, async: true

  alias Moz.BbCodes

  describe "bb_codes" do
    test "should parse empty" do
      assert {:ok, [""]} == BbCodes.call("")
    end

    test "should parse text" do
      text = BbCodes.call("text")
      assert {:ok, ["text"]} == text
    end

    test "error on mismatch token" do
      {:error, loc, msg} = BbCodes.call("[b]text")
      assert loc == {1, 7}
    end

    test "should parse bold" do
      assert {:ok, ["", {:b, ["text"], []}, ""]} == BbCodes.call("[b]text[/b]")
    end

    test "parse token sequence" do
      assert {:ok, ["", {:b, ["b"], []}, "", {:b, ["b"], []}, ""]} ==
               BbCodes.call("[b]b[/b][b]b[/b]")
    end

    test "recursive token" do
      assert {:ok, ["", {:b, ["", {:b, ["b"], []}, ""], []}, ""]} ==
               BbCodes.call("[b][b]b[/b][/b]")
    end

    test "invalid token continuation" do
      assert {:ok, ["[bbb]ss"]} == BbCodes.call("[bbb]ss")
    end

    test "i" do
      assert {:ok, ["", {:i, ["i"], []}, ""]} == BbCodes.call("[i]i[/i]")
    end

    test "u" do
      assert {:ok, ["", {:u, ["u"], []}, ""]} == BbCodes.call("[u]u[/u]")
    end

    test "s" do
      assert {:ok, ["", {:s, ["s"], []}, ""]} == BbCodes.call("[s]s[/s]")
    end
  end
end
