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

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("post", payload, socket) do
    id = List.last(String.split(socket.topic,":"))
    payload = %{"post" => payload["post"], "user_id" => id}
    case Social.create_message(payload) do
      {:ok, message} ->
        payload = Map.put(payload, :updated_at, message.updated_at)
        broadcast socket, "message", payload
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
