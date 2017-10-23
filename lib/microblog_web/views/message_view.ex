defmodule MicroblogWeb.MessageView do
  use MicroblogWeb, :view
  alias Microblog.Social
  alias Microblog.Social.Message

  def as_html(post) do
    post
    |> Earmark.as_html!
    |> raw
  end

end
