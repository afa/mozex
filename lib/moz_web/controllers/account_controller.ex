defmodule MozWeb.AccountController do
  use MozWeb, :controller

  alias Moz.Mozaic
  alias Moz.Account
  alias Moz.Accounts

  def login(conn, %{"login" => login, "password" => password} = params) do
    {:ok, user} = Accounts.locate_user(login, password)
    {:ok, token} = Accounts.setup_token(user)
    conn
    |> assign(:current_user, user)
    |> put_resp_cookie("moz_token", token)
    |> redirect(to: ~p"/")
  end

  def logout(conn, _params) do
    redirect(conn, to: ~p"/")
  end
  # def index(conn, _params) do
  #   account = Mozaic.list_account()
  #   render(conn, :index, account_collection: account)
  # end

  # def new(conn, _params) do
  #   changeset = Mozaic.change_account(%Account{})
  #   render(conn, :new, changeset: changeset)
  # end

  # def create(conn, %{"account" => account_params}) do
  #   case Mozaic.create_account(account_params) do
  #     {:ok, account} ->
  #       conn
  #       |> put_flash(:info, "Account created successfully.")
  #       |> redirect(to: ~p"/account/#{account}")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :new, changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   account = Mozaic.get_account!(id)
  #   render(conn, :show, account: account)
  # end

  # def edit(conn, %{"id" => id}) do
  #   account = Mozaic.get_account!(id)
  #   changeset = Mozaic.change_account(account)
  #   render(conn, :edit, account: account, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "account" => account_params}) do
  #   account = Mozaic.get_account!(id)

  #   case Mozaic.update_account(account, account_params) do
  #     {:ok, account} ->
  #       conn
  #       |> put_flash(:info, "Account updated successfully.")
  #       |> redirect(to: ~p"/account/#{account}")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :edit, account: account, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   account = Mozaic.get_account!(id)
  #   {:ok, _account} = Mozaic.delete_account(account)

  #   conn
  #   |> put_flash(:info, "Account deleted successfully.")
  #   |> redirect(to: ~p"/account")
  # end
end
