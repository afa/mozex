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
end
