defmodule Moz.Account do
  use Ecto.Schema

  schema("account") do
    field :token, :string
    belongs_to :user, Moz.User
  end
end
