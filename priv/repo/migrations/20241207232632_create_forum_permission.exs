defmodule Moz.Repo.Migrations.CreateForumPermission do
  use Ecto.Migration

  def change do
    create table(:forum_permission) do
      add :permissions, :integer
      add :forum_id, references("forum", on_delete: :delete_all), null: false
      add :user_group_id, references("user_group", on_delete: :delete_all), null: true
    end
  end
end
