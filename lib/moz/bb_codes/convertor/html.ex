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

  defp produce(:new_line, _inside, _params) do
    "<br/>"
  end
end
