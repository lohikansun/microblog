defmodule :"Elixir.Microblog.Repo.Migrations.Like-fix" do
  use Ecto.Migration

  def change do
    drop constraint(:likes, "likes_message_id_fkey")
    alter table(:likes) do
      modify :message_id, references(:messages, on_delete: :delete_all)
    end
  end
end
