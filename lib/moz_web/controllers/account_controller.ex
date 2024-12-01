defmodule MozWeb.AccountController do
  use MozWeb, :controller

  alias Moz.Mozaic
  alias Moz.Account
  alias Moz.Accounts

  def login(conn, %{"login" => login, "password" => password} = params) do
    with {:ok, user} <- Accounts.locate_user(login, password),
         {:ok, token} <- Accounts.setup_token(user)
    do
      conn
      |> assign(:current_user, user)
      |> put_resp_cookie("moz_token", token)
      |> redirect(to: ~p"/")
    else
      {:error, _} ->
        conn
        |> put_flash(:error, "Login failed")
        |> redirect(to: ~p"/")
    end
  end

  def logout(conn, _params) do
    conn
    |> assign(:current_user, nil)
    |> put_resp_cookie("moz_token", "")
    |> redirect(to: ~p"/")
  end
end
