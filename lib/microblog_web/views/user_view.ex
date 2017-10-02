require IEx
defmodule MicroblogWeb.UserView do
  use MicroblogWeb, :view

  def is_following(user, follow) do
    u = user |> Microblog.Repo.preload(:follows)
    Enum.any?(u.follows, fn(x) -> (x.user_id == user.id) and (x.follow_id == follow) end)   
  end

end
