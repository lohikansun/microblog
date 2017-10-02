defmodule MicroblogWeb.FollowController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts
  alias Microblog.Accounts.Follow

  def follow(conn, params) do
    case Accounts.create_follow(params) do
      {:ok, message} ->
        conn
        |> put_flash(:info, "Followed.")
        |> redirect(to: user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:info, "Not Followed")
        |> redirect(to: user_path(conn, :index))
    end

  end
  

  def delete(conn, %{"id" => id}) do
    follow = Accounts.get_follow!(id)
    {:ok, _follow} = Accounts.delete_follow(follow)
    conn
    |> put_flash(:info, "Unfollowed.")
    |> redirect(to: user_path(conn, :index))
  end
end
