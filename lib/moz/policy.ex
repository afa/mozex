defmodule Moz.Policy do
  def can?(%Moz.User{id: nil}, :users), do: false

  def can?(%Moz.User{}, :users), do: true

  def can?(%Moz.User{id: nil}, :thread, :show), do: false

  def can?(%Moz.User{}, :thread, :show), do: true
end
