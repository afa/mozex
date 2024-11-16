defmodule Moz.MozaicFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Moz.Mozaic` context.
  """

  @doc """
  Generate a forum.
  """
  def forum_fixture(attrs \\ %{}) do
    {:ok, forum} =
      attrs
      |> Enum.into(%{

      })
      |> Moz.Mozaic.create_forum()

    forum
  end
end
