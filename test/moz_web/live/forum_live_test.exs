defmodule MozWeb.ForumLiveTest do
  use MozWeb.ConnCase

  import Phoenix.LiveViewTest
  import Moz.MozaicFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_forum(_) do
    forum = forum_fixture()
    %{forum: forum}
  end

  describe "Index" do
    setup [:create_forum]

    test "lists all forum", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/forum")

      assert html =~ "Listing Forum"
    end

    test "saves new forum", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/forum")

      assert index_live |> element("a", "New Forum") |> render_click() =~
               "New Forum"

      assert_patch(index_live, ~p"/forum/new")

      assert index_live
             |> form("#forum-form", forum: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#forum-form", forum: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/forum")

      html = render(index_live)
      assert html =~ "Forum created successfully"
    end

    test "updates forum in listing", %{conn: conn, forum: forum} do
      {:ok, index_live, _html} = live(conn, ~p"/forum")

      assert index_live |> element("#forum-#{forum.id} a", "Edit") |> render_click() =~
               "Edit Forum"

      assert_patch(index_live, ~p"/forum/#{forum}/edit")

      assert index_live
             |> form("#forum-form", forum: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#forum-form", forum: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/forum")

      html = render(index_live)
      assert html =~ "Forum updated successfully"
    end

    test "deletes forum in listing", %{conn: conn, forum: forum} do
      {:ok, index_live, _html} = live(conn, ~p"/forum")

      assert index_live |> element("#forum-#{forum.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#forum-#{forum.id}")
    end
  end

  describe "Show" do
    setup [:create_forum]

    test "displays forum", %{conn: conn, forum: forum} do
      {:ok, _show_live, html} = live(conn, ~p"/forum/#{forum}")

      assert html =~ "Show Forum"
    end

    test "updates forum within modal", %{conn: conn, forum: forum} do
      {:ok, show_live, _html} = live(conn, ~p"/forum/#{forum}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Forum"

      assert_patch(show_live, ~p"/forum/#{forum}/show/edit")

      assert show_live
             |> form("#forum-form", forum: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#forum-form", forum: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/forum/#{forum}")

      html = render(show_live)
      assert html =~ "Forum updated successfully"
    end
  end
end
