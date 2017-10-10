defmodule Microblog.SocialTest do
  use Microblog.DataCase

  alias Microblog.Social

  describe "messages" do
    alias Microblog.Social.Message

    @valid_attrs %{post: "some post", user: "some user"}
    @update_attrs %{post: "some updated post", user: "some updated user"}
    @invalid_attrs %{post: nil, user: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Social.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Social.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Social.create_message(@valid_attrs)
      assert message.post == "some post"
      assert message.user == "some user"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = Social.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.post == "some updated post"
      assert message.user == "some updated user"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_message(message, @invalid_attrs)
      assert message == Social.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Social.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Social.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Social.change_message(message)
    end
  end

  describe "likes" do
    alias Microblog.Social.Like

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def like_fixture(attrs \\ %{}) do
      {:ok, like} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_like()

      like
    end

    test "list_likes/0 returns all likes" do
      like = like_fixture()
      assert Social.list_likes() == [like]
    end

    test "get_like!/1 returns the like with given id" do
      like = like_fixture()
      assert Social.get_like!(like.id) == like
    end

    test "create_like/1 with valid data creates a like" do
      assert {:ok, %Like{} = like} = Social.create_like(@valid_attrs)
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      assert {:ok, like} = Social.update_like(like, @update_attrs)
      assert %Like{} = like
    end

    test "update_like/2 with invalid data returns error changeset" do
      like = like_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_like(like, @invalid_attrs)
      assert like == Social.get_like!(like.id)
    end

    test "delete_like/1 deletes the like" do
      like = like_fixture()
      assert {:ok, %Like{}} = Social.delete_like(like)
      assert_raise Ecto.NoResultsError, fn -> Social.get_like!(like.id) end
    end

    test "change_like/1 returns a like changeset" do
      like = like_fixture()
      assert %Ecto.Changeset{} = Social.change_like(like)
    end
  end
end
