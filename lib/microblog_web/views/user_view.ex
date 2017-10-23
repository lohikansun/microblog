defmodule MicroblogWeb.UserView do
  use MicroblogWeb, :view

  def imageSrc(id) do
    path = :code.priv_dir(:microblog)
    "#{path}/static/profiles/#{id}-picture.jpg"

  end

  def as_html(post) do
    post
    |> Earmark.as_html!
    |> raw
  end

  def is_following(user, follow) do
    u = user |> Microblog.Repo.preload(:follows)
    Enum.any?(u.follows, fn(x) -> (x.user_id == user.id) and (x.follow_id == follow) end)
  end

end
