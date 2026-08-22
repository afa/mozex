defmodule Moz.BbCodes do
  alias Moz.BbCodes.Tokenizer
  alias Moz.BbCodes.Builder

  @moduledoc """
  parses bb codes, converts text to ast with text and token structured and closed into tuples

  """
  def call(text) do
    {:ok, tokens, _} =
      text
      |> to_char_list()
      |> :bb_tokenize.string()

    tokens
    |> IO.inspect()
    |> :bb_tokens.parse()
    |> IO.inspect()

    # |> IO.inspect()
    # |> init_context
    # |> IO.inspect()
    # |> process
  end

  @doc """
    Initializes the context for parsing BB codes.
    tokenizing text with BbCodes.Tokenizer
  """
  defp init_context(text) do
    with {:ok, tokens} <- Tokenizer.call(text) do
      tokens
      |> IO.inspect()
    end
  end

  defp process(tokens) do
    tokens
    |> Builder.call()
  end
end
