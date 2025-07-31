defmodule Moz.BbCodes.Tokenizer do
  require Result

  @moduledoc """
  задача порезать текст на участки помеченные как текст, токен, (закрывающий токен?), смайл.
  не строится аст дерево, только списки. соответственно стека нет, валидации закрытия токена нет.
    резать побуквенно, парсить побуквенно, напихивая текстовые символы в листы, помечая в потоке
    начало токена (или завершающего токена - [ or [/) или смайла(::), конец токена(]). смайлы симметричны
    раскладывать в туплы {:type, value(list or string), opts}
    возращать плоский список (flatten в конце?)
  """

  def call(text) do
    chars = String.split(text, "")
    xscan({:text, [], [], nil, nil, chars})
    |> Result.ok
  end

  @doc """
  params: tuple with
  current token type: (_:text_, :token, :smile) - безымянный параметр, для паттерн матч
  accum: список, накопитель текущего токена (для текста непрерывный текст, для разбираемого токена
  имя и параметры до закрытия токена). при смене типа токена мержится и добавляется к результату
  rezult: список, накапливаемый результат, в него добавляются завершенные в аккуме токены
  prev_char: предыдущая буква, кандидат на добавление в аккумулятор
  current_char: распаршенная на предыдущей итерации буква, для определения токена и переноса в prev_char
  или сохранения в токен при завершении токена
  chars: список разделенных букв, хвост текста.
  behavior: завершение итераций определяется пустым chars - дописываем prev_char, current_char в accum,
  accum добавляем в rezult, возвращаем результат
  стартуем с пустого результата, с пустым аккумом типа :text, nil в prev_char и current_char -
  """
  def xscan({:text, rezult, accum, prev_char, current_char, []}) do
    processed_accum = List.flatten([accum, prev_char, current_char])
    |>Enum.filter(fn
      nil -> false
      "" -> false
      _ -> true
    end)
    |>Enum.join("")
    List.flatten(rezult, [%Moz.BbCodes.BbToken{type: :text, value: processed_accum}])
  end
  # add for token start
  def xscan({:text, rezult, accum, prev_char, current_char, [head | tail]}) do
    xscan({:text, rezult, [accum, prev_char], current_char, head, tail})
  end

@doc """
  params:
  state - перед распознанием текущей char, относится к моменту распознания curr
  состояния - текст, тело токена. обработка смайлов позже
  [ в char и стейте текст - сброс предыдущего буфера с токеном текст и начало нового потока, стейт тело токена
  [ в char и стейт тело токена - сброс буфера с токеном текст и начало нового потока стейт тело токена
  ] в char и стейт тело токена - сброс буфера с токеном токен и начало нового потока стейт текст
  ] в char и стейт текст - продолжаем наполнять буфер
"""
  defp scan({:text, accum, rezult, prev, curr, char, []}) do
    # end scan
    # flush accum, return it as text
    rez =
      [accum, prev || "", curr || "", char]
      |> List.flatten()
      |> trim

    [rezult, {:text, rez}]
    |> List.flatten()
  end

  defp scan({:token, accum, rezult, prev, curr, "]", []}) do
    # close tag, return accum as token
    # end scan
    rez =
      [accum, prev || "", curr || "", "]"]
      |> List.flatten()
      |> trim

    [rezult, {:token, rez}]
    |> List.flatten()
  end

  defp scan({:token, accum, rezult, prev, curr, char, []}) do
    # flush accum, return as text
    # end scan
    rez =
      [accum, prev || "", curr || "", char]
      |> List.flatten()
      |> trim

    [rezult, {:text, rez}]
    |> List.flatten()
  end

  # open token in token
  defp scan({:token, accum, rezult, prev, curr, "[", chars}) do
    # flush accum as text start new token
    text = {:text, List.flatten([accum, prev || "", curr || ""]) |> trim}
    new_rezult = [rezult, text]
    [h | t] = chars
    scan({:token, [], new_rezult, nil, "[", h, t})
  end

  # close token
  defp scan({:token, accum, rezult, prev, curr, "]", chars}) do
    # close token flush accum as token
    tok = {:token, List.flatten([accum, prev || "", curr || "", "]"]) |> trim}
    new_rezult = [rezult, tok]
    [h | t] = chars
    scan({:text, [], new_rezult, nil, nil, h, t})
  end

  # open in text
  defp scan({:text, accum, rezult, prev, curr, "[", chars}) do
    text = {:text, List.flatten([accum, prev || "", curr || ""]) |> trim}
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

  @doc """
    Trim nils and empty strings from a list of tokens.
  """
  defp trim([nil | tail]), do: trim(tail)
  defp trim(["" | tail]), do: trim(tail)
  defp trim(list), do: list
end
