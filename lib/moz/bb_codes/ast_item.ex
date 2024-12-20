defmodule Moz.BbCodes.AstStruct do
  defstruct type: :text, value: '', opts: %{}
end

defimpl String.Chars, for: Moz.BbCodes.AstStruct do
  def to_string(%Moz.BbCodes.AstStruct{type: :text, value: value, opts: _} = struct) do
    value
  end
end
