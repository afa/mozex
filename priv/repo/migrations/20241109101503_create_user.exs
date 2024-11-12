defmodule Moz.Repo.Migrations.CreateUser do
  use Ecto.Migration
  def change do
    create table(:user) do
      add :name, :string, null: false
      add :email, :string
      add :password, :string, null: false
      add :password_on, :date, null: false
      add :salt, :string, null: false
      add :user_title, :string, null: false
    end
    create index(:user, [:name], unique: true)
    create index(:user, [:email])
  end
end
