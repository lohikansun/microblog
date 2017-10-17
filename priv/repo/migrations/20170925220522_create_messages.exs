defmodule Microblog.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :post, :text
      add :user, :string

      timestamps()
    end

  end
end
