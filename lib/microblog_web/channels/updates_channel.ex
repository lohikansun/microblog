require IEx
defmodule MicroblogWeb.UpdatesChannel do
  use MicroblogWeb, :channel

  alias Microblog.Social
  alias Microblog.Social.Message
  alias Phoenix.Socket

  def join("updates:all", payload, socket) do
    socket = socket
    {:ok, socket}
  end

  def join("updates:" <> userId, payload, socket) do
    socket = socket
    {:ok, socket}
  end

  def handle_in("follows", payload, socket) do
    id = payload["user"]
    follows = %{}
    if (id == nil) do
      users = Microblog.Accounts.list_users
      follows = Enum.map(users, fn (x) -> x.id end)
    else
    user = Microblog.Accounts.get_user_preloaded(id)
    follows = Enum.map(user.follows, fn (x) -> x.follow_id end)
    end
    payload = Map.put(payload, :follows, follows)
    {:reply, {:ok, payload}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("post", payload, socket) do
    id = List.last(String.split(socket.topic,":"))
    email = Microblog.Accounts.get_user!(id).email
    payload = %{"post" => payload["post"], "user_id" => id}
    case Social.create_message(payload) do
      {:ok, message} ->
        response = Map.put(payload, :updated_at, message.updated_at)
        response = Map.put(response, :user_email, email)
        broadcast socket, "message", response
        {:reply, {:ok, payload}, socket}
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, %{reason: "failed"}}
    end
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (updates:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
