defmodule Moz.BbCodes do
  alias Moz.BbCodes.Tokenizer

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
    with {:ok, tokens} <- Tokenizer.call(text) |> IO.inspect() do
      %{ast: [], tokens: tokens, token: nil, type: :text}
    end
  end

  # :process method
  # token type :open :close :single :text (:smile),
  # token name,
  # params,
  # tokens stream from tokenizer.
  # top token - text, parser returns its stream and tokens tail
  # closing token with other than name now converted to text, later can check with tokens stack and autoclose current token
  # text - add to stream
  # token - build stream, recursivelly add tokens to stream end

  # stream ended, tokens = []
  # append token to accum
  # convert accum to ast item
  # return ast
  defp process(%{ast: ast, token: token, tokens: [], type: type}) do
    ast
    |> Enum.reverse()
  end

  defp process(
         %{
           ast: ast,
           token: token,
           tokens: [head | tail] = tokens,
           type: type
         } = context
       ) do
    # {type, name, params} = ident_token(token)
    # rez =
    #   case ident_token(token) do
    #     {:open, token_name} ->
    #       make_level(token)

    #     {:close, token_name} ->
    #       # return(closed(level))
    #       nil

    #     {:single, list} ->
    #       # append(to(result and continue))
    #       nil
    #   end

    # make_level({})
  end

  # defp ident_token({:text, list}) do
  #   {:single}
  # end

  @doc """
  ast item: {:type, }
  type: text, tokenstart, opentokenbody

  return {:ok, level, tail}
  token_name: current token
  kind: yieldable/none
  opts: has or no opts in tag: y/n
  level: [] of text or tokens with subtree
  stream: tail of tokens list
  """
  # defp make_level({,,,,[]}), do: nil
  # defp make_level({:token, token_name, {kind, opts}, level, stream}), do: nil
  # defp make_level({:text, _, _, level, stream}), do: nil

  # ident_token state, prev_token, current_token, token
  # states: :text, :start_token
  # defp ident_token(:text, nil, :token_start, )

  # defp ident_token(:text, nil, nil, _), do: :text
end
