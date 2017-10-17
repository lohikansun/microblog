defmodule Microblog.AccountTest do
  use Microblog.DataCase

  alias Microblog.Account

  describe "follows" do
    alias Microblog.Account.Follow

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def follow_fixture(attrs \\ %{}) do
      {:ok, follow} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_follow()

      follow
    end

    test "list_follows/0 returns all follows" do
      follow = follow_fixture()
      assert Account.list_follows() == [follow]
    end

    test "get_follow!/1 returns the follow with given id" do
      follow = follow_fixture()
      assert Account.get_follow!(follow.id) == follow
    end

    #test "create_follow/1 with valid data creates a follow" do
  #    assert {:ok, %Follow{} = follow} = Account.create_follow(@valid_attrs)
  #  end

    test "create_follow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_follow(@invalid_attrs)
    end

    #test "update_follow/2 with valid data updates the follow" do
    #  follow = follow_fixture()
    #  assert {:ok, follow} = Account.update_follow(follow, @update_attrs)
    #  assert %Follow{} = follow
    #end

    test "update_follow/2 with invalid data returns error changeset" do
      follow = follow_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_follow(follow, @invalid_attrs)
      assert follow == Account.get_follow!(follow.id)
    end

    #test "delete_follow/1 deletes the follow" do
    #  follow = follow_fixture()
    #  assert {:ok, %Follow{}} = Account.delete_follow(follow)
    #  assert_raise Ecto.NoResultsError, fn -> Account.get_follow!(follow.id) end
    #end

    test "change_follow/1 returns a follow changeset" do
      follow = follow_fixture()
      assert %Ecto.Changeset{} = Account.change_follow(follow)
    end
  end
end
