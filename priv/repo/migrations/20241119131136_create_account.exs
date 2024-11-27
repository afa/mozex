defmodule Moz.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table("account") do
      add :token, :string
      add :user_id, references("user")
    end
    create index("account", [:token], unique: true)
    create index("account", [:user_id], unique: true)
  end
end
