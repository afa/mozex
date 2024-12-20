defmodule Moz.BbCodes do
  def call(text) do
    init_context(text)
    # |> process
    |> IO.inspect
  end

  defp process(%{ast: ast, prev_token: prev, current_token: current, tokens: tokens, state: state} = context) do
    if Enum.empty?(tokens) do
      context
    else
      [token | tail] = tokens
      {new_token, new_ast} = case new_state = ident_token(state, prev, current, token) do
        :text ->
          {token, [ast | [{:text, token}]]}
      end
        new_context = %{ast: new_ast, token: new_token, prev_token: nil, current_token: nil, state: new_state, tokens: tail}
        process(new_context)
    end
  end
  # ast item: {:type, }
  # type: text, tokenstart, opentokenbody

  # резать побуквенно, парсить побуквенно, напихивая текстовые символы в листы, помечая в потоке начало токена
  #  (или завершающего токена - [ or [/) или смайла(::), конец токена(]). смайлы симметричны
  # раскладывать в туплы {:type, value(list or string), opts}
  # возращать плоский список (flatten в конце?)
  defp tokenize(text) do
    chars = String.split(text, "") # TODO: дополнить
    scan({:text, [], [], nil, nil, hd(chars), tl(chars)})
  end

  # state - перед распознанием текущей char, относится к моменту распознания curr
  # состояния - текст, тело токена. обработка смайлов позже
  # [ в char и стейте текст - сброс предыдущего буфера с токеном текст и начало нового потока, стейт тело токена
  # [ в char и стейт тело токена - сброс буфера с токеном текст и начало нового потока стейт тело токена
  # ] в char и стейт тело токена - сброс буфера с токеном токен и начало нового потока стейт текст
  # ] в char и стейт текст - продолжаем наполнять буфер
  defp scan({:text, accum, rezult, prev, curr, char, []}) do
    # end scan
    # flush accum, return it as text
    rez = [accum, prev || "", curr || "", char]
          |> List.flatten
    [rezult, {:text, rez}]
    |> List.flatten
  end
  defp scan({:token, accum, rezult, prev, curr, "]", []}) do
    # close tag, return accum as token
    # end scan
    rez = [accum, prev || "", curr || "", "]"]
          |> List.flatten
    [rezult, {:token, rez}]
    |> List.flatten
  end
  defp scan({:token, accum, rezult, prev, curr, char, []}) do
    # flush accum, return as text
    # end scan
    rez = [accum, prev || "", curr || "", char]
          |> List.flatten
    [rezult, {:text, rez}]
    |> List.flatten
  end

  # open token in token
  defp scan({:token, accum, rezult, prev, curr, "[", chars}) do
    # flush accum as text start new token
    text = {:text, List.flatten([accum, prev || "", curr || ""])}
    new_rezult = [rezult, text]
    [h | t] = chars
    scan({:token, [], new_rezult, nil, "[", h, t})
  end
  # close token
  defp scan({:token, accum, rezult, prev, curr, "]", chars}) do
    # close token flush accum as token
    tok = {:token, List.flatten([accum, prev || "", curr || "", "]"])}
    new_rezult = [rezult, tok]
    [h | t] = chars
    scan({:text, [], new_rezult, nil, nil, h, t})
  end
  # open in text
  defp scan({:text, accum, rezult, prev, curr, "[", chars}) do
    text = {:text, List.flatten([accum, prev || "", curr || ""])}
    new_rezult = [rezult, text]
    [h | t] = chars
    scan({:token, [], new_rezult, nil, "[", h, t})
  end
  # regular any
  defp scan({state, accum, rezult, prev, curr, char, chars}) do
    new_acc = [accum, prev]
    [h | t] = chars
    scan({state, new_acc, rezult, curr, char, h, t})
  end

  defp init_context(text) do
    tokens = tokenize(text)
    # tokens = String.split(text, ~r{\b}u)
    %{ast: [], tokens: tokens, prev_token: nil, current_token: nil, state: :text}
  end

  # ident_token state, prev_token, current_token, token
  # states: :text, :start_token
  # defp ident_token(:text, nil, :token_start, )

  defp ident_token(:text, nil, nil, _), do: :text
end
