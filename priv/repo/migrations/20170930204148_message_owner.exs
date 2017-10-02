defmodule Microblog.Repo.Migrations.MessageOwner do
  use Ecto.Migration

  def change do
    alter table("messages") do
      add :user_id, references(:users, on_delete: :delete_all)
      remove :user
    end
  end
end
