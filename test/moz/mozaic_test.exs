defmodule Moz.MozaicTest do
  use Moz.DataCase

  alias Moz.Mozaic

  describe "forum" do
    alias Moz.Mozaic.Forum

    import Moz.MozaicFixtures

    @invalid_attrs %{}

    test "list_forum/0 returns all forum" do
      forum = forum_fixture()
      assert Mozaic.list_forum() == [forum]
    end

    test "get_forum!/1 returns the forum with given id" do
      forum = forum_fixture()
      assert Mozaic.get_forum!(forum.id) == forum
    end

    test "create_forum/1 with valid data creates a forum" do
      valid_attrs = %{}

      assert {:ok, %Forum{} = forum} = Mozaic.create_forum(valid_attrs)
    end

    test "create_forum/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mozaic.create_forum(@invalid_attrs)
    end

    test "update_forum/2 with valid data updates the forum" do
      forum = forum_fixture()
      update_attrs = %{}

      assert {:ok, %Forum{} = forum} = Mozaic.update_forum(forum, update_attrs)
    end

    test "update_forum/2 with invalid data returns error changeset" do
      forum = forum_fixture()
      assert {:error, %Ecto.Changeset{}} = Mozaic.update_forum(forum, @invalid_attrs)
      assert forum == Mozaic.get_forum!(forum.id)
    end

    test "delete_forum/1 deletes the forum" do
      forum = forum_fixture()
      assert {:ok, %Forum{}} = Mozaic.delete_forum(forum)
      assert_raise Ecto.NoResultsError, fn -> Mozaic.get_forum!(forum.id) end
    end

    test "change_forum/1 returns a forum changeset" do
      forum = forum_fixture()
      assert %Ecto.Changeset{} = Mozaic.change_forum(forum)
    end
  end

  describe "dashboard" do
    alias Moz.Mozaic.Dashboard

    import Moz.MozaicFixtures

    @invalid_attrs %{}

    test "list_dashboard/0 returns all dashboard" do
      dashboard = dashboard_fixture()
      assert Mozaic.list_dashboard() == [dashboard]
    end

    test "get_dashboard!/1 returns the dashboard with given id" do
      dashboard = dashboard_fixture()
      assert Mozaic.get_dashboard!(dashboard.id) == dashboard
    end

    test "create_dashboard/1 with valid data creates a dashboard" do
      valid_attrs = %{}

      assert {:ok, %Dashboard{} = dashboard} = Mozaic.create_dashboard(valid_attrs)
    end

    test "create_dashboard/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mozaic.create_dashboard(@invalid_attrs)
    end

    test "update_dashboard/2 with valid data updates the dashboard" do
      dashboard = dashboard_fixture()
      update_attrs = %{}

      assert {:ok, %Dashboard{} = dashboard} = Mozaic.update_dashboard(dashboard, update_attrs)
    end

    test "update_dashboard/2 with invalid data returns error changeset" do
      dashboard = dashboard_fixture()
      assert {:error, %Ecto.Changeset{}} = Mozaic.update_dashboard(dashboard, @invalid_attrs)
      assert dashboard == Mozaic.get_dashboard!(dashboard.id)
    end

    test "delete_dashboard/1 deletes the dashboard" do
      dashboard = dashboard_fixture()
      assert {:ok, %Dashboard{}} = Mozaic.delete_dashboard(dashboard)
      assert_raise Ecto.NoResultsError, fn -> Mozaic.get_dashboard!(dashboard.id) end
    end

    test "change_dashboard/1 returns a dashboard changeset" do
      dashboard = dashboard_fixture()
      assert %Ecto.Changeset{} = Mozaic.change_dashboard(dashboard)
    end
  end

  describe "account" do
    alias Moz.Mozaic.Account

    import Moz.MozaicFixtures

    @invalid_attrs %{}

    test "list_account/0 returns all account" do
      account = account_fixture()
      assert Mozaic.list_account() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Mozaic.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{}

      assert {:ok, %Account{} = account} = Mozaic.create_account(valid_attrs)
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mozaic.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{}

      assert {:ok, %Account{} = account} = Mozaic.update_account(account, update_attrs)
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Mozaic.update_account(account, @invalid_attrs)
      assert account == Mozaic.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Mozaic.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Mozaic.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Mozaic.change_account(account)
    end
  end
end
