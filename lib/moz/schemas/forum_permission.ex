defmodule Moz.ForumPermission do
  use Ecto.Schema

  schema("forum_permission") do
    field :forum_permission, :integer
    belongs_to :forum, Moz.Forum
    belongs_to :user_group, Moz.UserGroup
  end
end
