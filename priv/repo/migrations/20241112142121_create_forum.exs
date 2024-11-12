defmodule Moz.Repo.Migrations.CreateForum do
  use Ecto.Migration

  def change do
    create table(:forum) do
      add :title, :string, null: false
      add :title_clean, :string, null: false
      add :description, :text, null: true
      add :description_clean, :text, null: true
      add :position, :integer, null: false, default: 0
      add :parent_id, references("forum") # , on_delete: :nullify)
    end
  end
end
