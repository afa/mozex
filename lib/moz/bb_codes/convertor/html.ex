defmodule Moz.BbCodes.Convertor.Html do
  @moduledoc """
  converts prepared parsed text with bbkodes to html
  """

  def call(list) do
    convert(list, [])
  end

  defp convert([], buf) do
    buf
    |> List.flatten()
    |> Enum.join()
  end

  defp convert([h | t], buf) when is_binary(h) do
    convert(t, [buf, h])
  end

  defp convert([h | t], buf) when is_tuple(h) do
    {token, inside, params} = h
    rez = produce(token, call(inside), params)
    convert(t, [buf, rez])
  end

  defp produce(:b, inside, _params) do
    Enum.join(["<b>", inside, "</b>"])
  end

  defp produce(:i, inside, _params) do
    Enum.join(["<i>", inside, "</i>"])
  end

  defp produce(:u, inside, _params) do
    Enum.join(["<u>", inside, "</u>"])
  end

  defp produce(:s, inside, _params) do
    Enum.join(["<s>", inside, "</s>"])
  end

  defp produce(:indent, inside, _params) do
    Enum.join(["<blockquote><div>", inside, "</div></blockquote>"])
  end

  defp produce(:highlite, inside, _params) do
    Enum.join(["<span class=\"highlite\">", inside, "</span>"])
  end

  defp produce(:left, inside, _params) do
    Enum.join(["<div align=left>", inside, "</div>"])
  end

  defp produce(:center, inside, _params) do
    Enum.join(["<div align=center>", inside, "</div>"])
  end

  defp produce(:right, inside, _params) do
    Enum.join(["<div align=right>", inside, "</div>"])
  end

  defp produce(:new_line, _inside, _params) do
    "<br/>"
  end
end
