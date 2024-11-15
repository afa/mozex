defmodule Moz.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Moz.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{

      })
      |> Moz.Users.create_user()

    user
  end
end
