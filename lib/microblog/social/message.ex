defmodule Microblog.Social.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Social.Message


  schema "messages" do
    field :post, :string
    belongs_to :user, Microblog.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:post, :user_id])
    |> validate_required([:post])
  end
end
