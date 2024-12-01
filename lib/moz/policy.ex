defmodule Moz.Policy do
  def can?(%Moz.User{id: nil}, :users), do: false

  def can?(%Moz.User{}, :users), do: true
end
