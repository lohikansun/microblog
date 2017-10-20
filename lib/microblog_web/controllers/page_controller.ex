defmodule MicroblogWeb.PageController do
  use MicroblogWeb, :controller

  def index(conn, _params) do
    if conn.assigns.current_user do
      redirect conn, to: "/feed"
    else
      redirect conn, to: user_path(conn, :landing)
    end
  end
end
