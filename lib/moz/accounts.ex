defmodule Moz.Accounts do
  import Ecto.Query
  require :crypto
  require SecureRandom

  def hash_from_password(password, salt) do
    hashed = :crypto.hash(:md5, password)
             |> Base.encode16(case: :lower)
    salted = hashed <> salt
    :crypto.hash(:md5, salted)
    |> Base.encode16(case: :lower)
  end

  def token do
    SecureRandom.hex(16)
  end

  def unique_token do
    Stream.repeatedly(&token/0)
    |> Stream.reject(&account_from_token(&1))
    |> Enum.take(1)
    |> hd()
  end

  def account_from_token(str) do
    from(a in Moz.Account,
      where: a.token == ^str,
      limit: 1
    )
    |> Moz.Repo.one
  end

  def user_from_token(str) do
    from(u in Moz.User,
      join: a in Moz.Account,
      on: a.user_id == u.id,
      where: a.token == ^str,
      limit: 1
    )
    |> Moz.Repo.one
  end

  def locate_user(login, password) do
    str = String.trim(login)
    user = from(u in Moz.User,
      where: u.name == ^str,
      limit: 1,
      select: u
    )
    |> Moz.Repo.one
    case user do
      nil ->
        {:error, :not_found}
      u ->
        check_password(u, password)
    end
  end

  defp check_password(user, password) do
    pass = user.password
    case hash_from_password(password, user.salt) do
      ^pass ->
        {:ok, user}
      _ ->
        {:error, :not_found}
    end
  end

  def setup_token(user) do
    account = case from(a in Moz.Account, where: a.user_id == ^user.id, limit: 1) |> Moz.Repo.one do
      nil ->
        Moz.Repo.insert!(%Moz.Account{user_id: user.id})
      acc ->
        acc
    end
    token = unique_token()
    case Moz.Repo.update(Ecto.Changeset.change(account, token: token)) do
      {:ok, _} ->
        {:ok, token}
      {:error, msg} ->
        {:error, msg}
    end
  end
end
