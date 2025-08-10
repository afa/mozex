defmodule Moz.BbCodes.AstStruct do
  defstruct type: :text, value: "", opts: %{}
end

defimpl String.Chars, for: Moz.BbCodes.AstStruct do
  def to_string(%Moz.BbCodes.AstStruct{type: :text, value: value, opts: _} = _struct) do
    value
  end

  # TODO: make implementation for opts driven + use token name
  def to_string(%Moz.BbCodes.AstStruct{type: :token, value: value, opts: _} = _struct) do
    Enum.join(value, "")
  end
end
