defmodule Moz.Repo.Migrations.CreateThread do
  use Ecto.Migration

  def change do
    create table("thread") do
      add :title, :string
      add :forum_id, references("forum", on_delete: :delete_all)
      add :last_post_at, :utc_datetime
      add :created_at, :utc_datetime
      add :open, :boolean
      add :visible, :boolean
      add :sticky, :boolean
      add :poster_name, :string
      add :poster_id, references("user")
    end
  end
end
