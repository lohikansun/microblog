defmodule Microblog.Accounts.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.Follow


  schema "follows" do
    belongs_to :user, Microblog.Accounts.User
    field :follow_id, :integer 
    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [:user_id, :follow_id])
    |> validate_required([])
  end
end
