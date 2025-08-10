defmodule Moz.BbCodes.Tokenizer do
  require Result
  require Moz.BbCodes.BbToken

  @moduledoc """
  задача порезать текст на участки помеченные как текст, токен, (закрывающий токен?), смайл.
  не строится аст дерево, только списки. соответственно стека нет, валидации закрытия токена нет.
    резать побуквенно, парсить побуквенно, напихивая текстовые символы в листы, помечая в потоке
    начало токена (или завершающего токена - [ or [/) или смайла(::), конец токена(]). смайлы симметричны
    раскладывать в туплы {:type, value(list or string), opts}
    возращать плоский список (flatten в конце?)
  """

  def call(text) do
    # IO.inspect([":0", text])
    chars = String.split(text, "")

    scan({:text, [], [], nil, nil, chars})
    |> Result.ok()
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
  def scan({:text, rezult, accum, prev_char, current_char, []} = args) do
    # IO.inspect([":1", args])
    processed_accum = transform_accum([accum, prev_char, current_char])
    transform_rezult([rezult, %Moz.BbCodes.BbToken{type: :text, value: processed_accum}])
  end

  def scan({:open, rezult, accum, prev_char, current_char, []} = args) do
    # IO.inspect([":1.1", args])
    processed_accum = transform_accum(["[", accum, prev_char, current_char])
    transform_rezult([rezult, %Moz.BbCodes.BbToken{type: :text, value: processed_accum}])
  end

  def scan({:close, rezult, accum, prev_char, current_char, []} = args) do
    # IO.inspect([":1.2", args])
    processed_accum = transform_accum(["[/", accum, prev_char, current_char])
    transform_rezult([rezult, %Moz.BbCodes.BbToken{type: :text, value: processed_accum}])
  end

  # closing :text, convert accum to BbToke, reinit accum from scratch, opens closing teg ([/])
  def scan({:text, rezult, accum, "[", "/", [head | tail]} = args) do
    # IO.inspect([":2", args])

    scan(
      {:close, [rezult, %Moz.BbCodes.BbToken{type: :text, value: transform_accum([accum])}], [],
       nil, head, tail}
    )
  end

  # closing :text, convert accum to BbToke, reinit accum from scratch, opens openning teg ([])
  def scan({:text, rezult, accum, "[", current_char, [head | tail]} = args) do
    # IO.inspect([":3", args])

    scan(
      {:open, [rezult, %Moz.BbCodes.BbToken{type: :text, value: transform_accum([accum])}], [],
       current_char, head, tail}
    )
  end

  # add for token start
  def scan({:text, rezult, accum, prev_char, current_char, [head | tail]} = args) do
    # IO.inspect([":4", args])
    scan({:text, rezult, [accum, prev_char], current_char, head, tail})
  end

  def scan({:open, rezult, accum, prev_char, "]", [head | tail]} = args) do
    # IO.inspect([":5", args])

    scan(
      {:text,
       [rezult, %Moz.BbCodes.BbToken{type: :open, value: transform_accum([accum, prev_char])}],
       [], nil, head, tail}
    )
  end

  def scan({:open, rezult, accum, prev_char, current_char, [head | tail]} = args) do
    # IO.inspect([":5.1", args])
    scan({:open, rezult, [accum, prev_char], current_char, head, tail})
  end

  def scan({:close, rezult, accum, prev_char, "]", [head | tail]} = args) do
    # IO.inspect([":6", args])

    scan(
      {:text,
       [rezult, %Moz.BbCodes.BbToken{type: :close, value: transform_accum([accum, prev_char])}],
       [], nil, head, tail}
    )
  end

  def scan({:close, rezult, accum, prev_char, current_char, [head | tail]} = args) do
    # IO.inspect([":7", args])
    scan({:close, rezult, [accum, prev_char], current_char, head, tail})
  end

  def transform_rezult(list) do
    list
    |> List.flatten()
    |> Enum.filter(fn
      %Moz.BbCodes.BbToken{type: _, opts: _, value: ""} -> false
      _ -> true
    end)
  end

  @doc """
  flattenize list, filter blanks, join to text
  """
  def transform_accum(list) do
    list
    |> List.flatten()
    |> Enum.filter(fn
      nil -> false
      "" -> false
      _ -> true
    end)
    |> Enum.join("")
  end
end
