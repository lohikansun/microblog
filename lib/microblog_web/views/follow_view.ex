defmodule MicroblogWeb.FollowView do
  use MicroblogWeb, :view

  def get_follow(user, follow) do
    u = user |> Microblog.Repo.preload(:follows)
    Enum.find(u.follows, fn(x) -> (x.user_id == user.id) and (x.follow_id == follow) end)
  end


end
