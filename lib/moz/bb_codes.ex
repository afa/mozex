defmodule Moz.BbCodes do
  alias Moz.BbCodes.Tokenizer
  alias Moz.BbCode.Builder

  @moduledoc """
  parses bb codes, converts text to ast with text and token structured and closed into tuples

  """
  def call(text) do
    text
    |> init_context
    |> process
  end

  @doc """
    Initializes the context for parsing BB codes.
    tokenizing text with BbCodes.Tokenizer
  """
  defp init_context(text) do
    with {:ok, tokens} <- Tokenizer.call(text) do
      tokens
    end
  end

  defp process(tokens) do
    tokens
    |> Builder.call()
  end
end
