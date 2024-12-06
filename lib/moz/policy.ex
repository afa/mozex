defmodule Moz.Policy do
  require Logger

  def can?(%Moz.User{id: nil}, :users), do: false

  def can?(%Moz.User{}, :users), do: true

  def can?(%Moz.User{id: nil}, :thread, :show), do: false

  def can?(%Moz.User{}, :thread, :show), do: true

  def can?(u, d) do
    Logger.warning("user: #{inspect(u)}, param: #{inspect(d)}")
    false
  end

  def can?(u, d, t) do
    Logger.warning("user: #{inspect(u)}, param: #{inspect(d)}, #{inspect(t)}")
    false
  end
end
