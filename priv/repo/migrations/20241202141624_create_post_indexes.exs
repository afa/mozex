defmodule Moz.Repo.Migrations.CreatePostIndexes do
  use Ecto.Migration

  def change do
    create index(:post, [:thread_id])
    create index(:post, [:report_thread_id])
    create index(:post, [:parent_id])
  end
end
