defmodule Moz.Contact do
  use Ecto.Schema

  schema("contact") do
    field :kind, Ecto.Enum, values: [unknown: 0, homepage: 1, icq: 2, aim: 3, yahoo: 4, msn: 5, skype: 6]
    belongs_to :user, Moz.User
    field :value, :string
    field :position, :integer
  end
end
