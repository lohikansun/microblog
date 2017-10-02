defmodule MicroblogWeb.Helpers do
  def nav_active?(view, text) do
    if String.contains?(to_string(view), text) do
      "active"
    else
      ""
    end
  end
end
