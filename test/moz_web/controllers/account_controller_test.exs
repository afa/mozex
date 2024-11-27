defmodule MozWeb.AccountControllerTest do
  use MozWeb.ConnCase

  import Moz.MozaicFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  describe "index" do
    test "lists all account", %{conn: conn} do
      conn = get(conn, ~p"/account")
      assert html_response(conn, 200) =~ "Listing Account"
    end
  end

  describe "new account" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/account/new")
      assert html_response(conn, 200) =~ "New Account"
    end
  end

  describe "create account" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/account", account: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/account/#{id}"

      conn = get(conn, ~p"/account/#{id}")
      assert html_response(conn, 200) =~ "Account #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/account", account: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Account"
    end
  end

  describe "edit account" do
    setup [:create_account]

    test "renders form for editing chosen account", %{conn: conn, account: account} do
      conn = get(conn, ~p"/account/#{account}/edit")
      assert html_response(conn, 200) =~ "Edit Account"
    end
  end

  describe "update account" do
    setup [:create_account]

    test "redirects when data is valid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/account/#{account}", account: @update_attrs)
      assert redirected_to(conn) == ~p"/account/#{account}"

      conn = get(conn, ~p"/account/#{account}")
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/account/#{account}", account: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Account"
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, ~p"/account/#{account}")
      assert redirected_to(conn) == ~p"/account"

      assert_error_sent 404, fn ->
        get(conn, ~p"/account/#{account}")
      end
    end
  end

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end
end
