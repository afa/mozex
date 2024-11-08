defmodule Moz.Repo do
  use Ecto.Repo,
    otp_app: :moz,
    adapter: Ecto.Adapters.Postgres
end
