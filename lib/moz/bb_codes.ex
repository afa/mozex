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
    with {:ok, tokens} <- Tokenizer.call(text)
    do
      %{ast: [], tokens: tokens, prev_token: nil, current_token: nil, state: :text}
    end
  end

  @doc """
    token type :open :close :single,
    token name,
    params,
    token stream.
    top token - text, parser returns its stream and tokens tail
    closing token with other than name now converted to text, later can check with tokens stack and autoclose current token
    text - add to stream
    token - build stream, recursivelly add tokens to stream end
  """
  defp process(
         %{
         ast: ast,
         prev_token: prev,
         current_token: current,
         tokens: tokens,
         state: state
         } = context
       ) do
    # {type, name, params} = ident_token(token)

    rez =
      case ident_token(current) do
        {:open, token_name} ->
          make_level(current)

        {:close, token_name} ->
          nil # return(closed(level))

        {:single, list} ->
          nil # append(to(result and continue))
      end

    make_level({})

    # if Enum.empty?(tokens) do
    #   context
    # else
    #   [token | tail] = tokens
    #   {new_token, new_ast} = case new_state = ident_token(state, prev, current, token) do
    #     :text ->
    #       {token, [ast | [{:text, token}]]}
    #   end
    #     new_context = %{ast: new_ast, token: new_token, prev_token: nil, current_token: nil, state: new_state, tokens: tail}
    #     process(new_context)
    # end
  end

  defp ident_token({:text, list}) do
    {:single}
  end

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
  defp make_level({:token, token_name, {kind, opts}, level, stream}), do: nil
  defp make_level({:text, _, _, level, stream}), do: nil


  # ident_token state, prev_token, current_token, token
  # states: :text, :start_token
  # defp ident_token(:text, nil, :token_start, )

  defp ident_token(:text, nil, nil, _), do: :text
end
