defmodule Moz.BbCodes.AstItem do
  defstruct type: :text, value: "", opts: %{}
end

defimpl String.Chars, for: Moz.BbCodes.AstStruct do
  def to_string(%Moz.BbCodes.AstItem{type: :text, value: value, opts: _} = _struct) do
    value
  end

  # TODO: make implementation for opts driven + use token name
  # AstItem with :token type - in value list of ast items for current level
  # ast item is a ordered childrens in value for typed node of ast tree
  def to_string(%Moz.BbCodes.AstItem{type: :token, value: value, opts: opts} = _struct) do
    case pre_postfix_from_opts(opts) do
      {first, last} -> Enum.join(List.flatten([first, value, last]), "")
    end
  end

  def pre_postfix_from_opts(opts) do
    {
      ["<", opts.tag, ">"] |> Enum.join(""),
      ["</", opts.tag, ">"] |> Enum.join("")
    }
  end
end
