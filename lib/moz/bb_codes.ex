defmodule Moz.BbCodes do
  @moduledoc """
  parses bb codes, converts text to ast with text and token structured and closed into tuples

  """
  def call(text) do
    with {:ok, tokens, _} <- :bb_tokenize.string(to_char_list(text)),
         {:ok, parsed} <- :bb_tokens.parse(tokens) do
      compact(parsed, [], [])
    else
      {:error, {{ln, col}, :bb_tokens, msg}} ->
        {:error, {ln, col}, msg}

      error ->
        {:error, {0, 0}, "some err"}
    end
  end

  defp compact([], buf, rez) do
    List.flatten([rez, Enum.join(buf)])
  end

  defp compact([h | t], buf, rez) when is_list(h) do
    compact(t, [buf, to_string(h)], rez)
  end

  defp compact([h | t], buf, rez) when is_tuple(h) do
    {tok, list, opts} = h
    item = compact(list, [], [])
    compact(t, [], [rez, Enum.join(buf), {tok, item, opts}])
  end
end
