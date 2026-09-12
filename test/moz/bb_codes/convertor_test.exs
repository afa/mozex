defmodule Moz.BbCodes.ConvertorTest do
  use ExUnit.Case

  alias Moz.BbCodes.Convertor.Html

  test "empty list" do
    assert "" == Html.call([])
  end

  test "text list" do
    assert "text" == Html.call(["text"])
  end

  describe "special token" do
    test "new_line" do
      assert "<br/>" == Html.call(["", {:new_line, [], []}, ""])
    end
  end

  describe "unparametrized tokens" do
    test "b" do
      assert "<b>b</b>" == Html.call(["", {:b, ["b"], []}, ""])
    end

    test "i" do
      assert "<i>i</i>" == Html.call(["", {:i, ["i"], []}, ""])
    end

    test "u" do
      assert "<u>u</u>" == Html.call(["", {:u, ["u"], []}, ""])
    end

    test "s" do
      assert "<s>s</s>" == Html.call(["", {:s, ["s"], []}, ""])
    end
  end
end
