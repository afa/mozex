defmodule Moz.Repo.Migrations.AddGroupsToUsers do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :user_group_id, references("user_group", on_delete: :delete_all), null: true
      add :tmp_member_group_ids, :string, null: true
      add :display_group_id, references("user_group", on_delete: :delete_all), null: true
      add :options, :integer, null: true
      add :admin_options, :integer, null: true
    end
  end
end
