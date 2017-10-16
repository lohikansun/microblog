defmodule MicroblogWeb.Helpers do
  def nav_active?(view, text) do
    if String.contains?(to_string(view), text) do
      "active"
    else
      ""
    end
  end

  # Function obtained from Nat Tuck draw project.
  def page_name(mm, tt) do
    modu = String.replace(to_string(mm), ~r/^.*\./, "")
    tmpl = String.replace(to_string(tt), ~r/\..*$/, "")
    "#{modu}/#{tmpl}"
  end
end
