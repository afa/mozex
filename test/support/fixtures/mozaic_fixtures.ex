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

  @doc """
  Generate a dashboard.
  """
  def dashboard_fixture(attrs \\ %{}) do
    {:ok, dashboard} =
      attrs
      |> Enum.into(%{

      })
      |> Moz.Mozaic.create_dashboard()

    dashboard
  end

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{

      })
      |> Moz.Mozaic.create_account()

    account
  end
end
