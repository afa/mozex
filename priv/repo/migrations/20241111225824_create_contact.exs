defmodule Moz.Repo.Migrations.CreateContact do
  use Ecto.Migration

  def change do
    create table(:contact) do
      add :kind, :integer, null: false
      add :user_id, references("user", on_delete: :delete_all), null: false
      add :value, :string, null: false
      add :position, :integer, null: false, default: 0
    end
    create index(:contact, [:user_id, :kind], unique: true)
    create index(:contact, [:position])
  end
end
