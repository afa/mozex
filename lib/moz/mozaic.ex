defmodule Moz.Mozaic do
  @moduledoc """
  The Mozaic context.
  """

  import Ecto.Query, warn: false
  alias Moz.Repo

  alias Moz.Forum

  @doc """
  Returns the list of forum.

  ## Examples

      iex> list_forum()
      [%Forum{}, ...]

  """
  def list_forum do
    from(f in Forum,
      where: is_nil(f.parent_id),
      order_by: f.position,
      preload: [:children],
      select: f
    )
    |> Repo.all
  end

  @doc """
  Gets a single forum.

  Raises if the Forum does not exist.

  ## Examples

      iex> get_forum!(123)
      %Forum{}

  """
  def get_forum!(id) do
    from(f in Forum,
      where: f.id == ^id,
      select: f
    )
    |> Repo.one
  end

  @doc """
  Gets a single forum with top children.

  Raises if the Forum does not exist.

  ## Examples

      iex> get_forum_with_tops!(123, 3)
      %Forum{}

  """
  def list_forums_with_tops!(parent_id, size) do
    childs_query = from c in Forum, order_by: c.position # , limit: ^size
    case parent_id do
      nil ->
        from(f in Forum,
          where: is_nil(f.parent_id),
          preload: [children: ^childs_query],
          order_by: f.position,
          select: f
        )
      _ ->
        from(f in Forum,
          where: f.parent_id == ^parent_id,
          preload: [children: ^childs_query],
          order_by: f.position,
          select: f
        )
    end
    |> Repo.all
  end

  @doc """
  Gets a single forum with top children.

  Raises if the Forum does not exist.

  ## Examples

      iex> get_forum_with_tops!(123, 3)
      %Forum{}

  """
  def get_forum_with_tops!(id, size) do
    childs_query = from c in Forum, order_by: c.position # , limit: ^size
    from(f in Forum,
      where: f.id == ^id,
      preload: [children: ^childs_query],
      preload: [:threads],
      select: f
    )
    |> Repo.one
  end

  @doc """
  Creates a forum.

  ## Examples

      iex> create_forum(%{field: value})
      {:ok, %Forum{}}

      iex> create_forum(%{field: bad_value})
      {:error, ...}

  """
  def create_forum(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a forum.

  ## Examples

      iex> update_forum(forum, %{field: new_value})
      {:ok, %Forum{}}

      iex> update_forum(forum, %{field: bad_value})
      {:error, ...}

  """
  def update_forum(%Forum{} = forum, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Forum.

  ## Examples

      iex> delete_forum(forum)
      {:ok, %Forum{}}

      iex> delete_forum(forum)
      {:error, ...}

  """
  def delete_forum(%Forum{} = forum) do
    raise "TODO"
  end

  @desc """
  """
  def load_forum_parent(%Forum{} = forum) do
    from(f in Forum,
      where: f.id == ^forum.parent_id,
      select: f,
      preload: [:parent]
    )
    |> Repo.one
  end
  @doc """
  Returns a data structure for tracking forum changes.

  ## Examples

      iex> change_forum(forum)
      %Todo{...}

  """
  def change_forum(%Forum{} = forum, _attrs \\ %{}) do
    raise "TODO"
  end

  # @doc """
  # Returns the list of dashboard.

  # ## Examples

  #     iex> list_dashboard()
  #     [%Dashboard{}, ...]

  # """
  # def list_dashboard do
  #   raise "TODO"
  # end

  # @doc """
  # Gets a single dashboard.

  # Raises if the Dashboard does not exist.

  # ## Examples

  #     iex> get_dashboard!(123)
  #     %Dashboard{}

  # """
  # def get_dashboard!(id), do: raise "TODO"

  # @doc """
  # Creates a dashboard.

  # ## Examples

  #     iex> create_dashboard(%{field: value})
  #     {:ok, %Dashboard{}}

  #     iex> create_dashboard(%{field: bad_value})
  #     {:error, ...}

  # """
  # def create_dashboard(attrs \\ %{}) do
  #   raise "TODO"
  # end

  # @doc """
  # Updates a dashboard.

  # ## Examples

  #     iex> update_dashboard(dashboard, %{field: new_value})
  #     {:ok, %Dashboard{}}

  #     iex> update_dashboard(dashboard, %{field: bad_value})
  #     {:error, ...}

  # """
  # def update_dashboard(%Dashboard{} = dashboard, attrs) do
  #   raise "TODO"
  # end

  # @doc """
  # Deletes a Dashboard.

  # ## Examples

  #     iex> delete_dashboard(dashboard)
  #     {:ok, %Dashboard{}}

  #     iex> delete_dashboard(dashboard)
  #     {:error, ...}

  # """
  # def delete_dashboard(%Dashboard{} = dashboard) do
  #   raise "TODO"
  # end

  # @doc """
  # Returns a data structure for tracking dashboard changes.

  # ## Examples

  #     iex> change_dashboard(dashboard)
  #     %Todo{...}

  # """
  # def change_dashboard(%Dashboard{} = dashboard, _attrs \\ %{}) do
  #   raise "TODO"
  # end

  # alias Moz.Account

  # @doc """
  # Returns the list of account.

  # ## Examples

  #     iex> list_account()
  #     [%Account{}, ...]

  # """
  # def list_account do
  #   raise "TODO"
  # end

  # @doc """
  # Gets a single account.

  # Raises if the Account does not exist.

  # ## Examples

  #     iex> get_account!(123)
  #     %Account{}

  # """
  # def get_account!(id), do: raise "TODO"

  # @doc """
  # Creates a account.

  # ## Examples

  #     iex> create_account(%{field: value})
  #     {:ok, %Account{}}

  #     iex> create_account(%{field: bad_value})
  #     {:error, ...}

  # """
  # def create_account(attrs \\ %{}) do
  #   raise "TODO"
  # end

  # @doc """
  # Updates a account.

  # ## Examples

  #     iex> update_account(account, %{field: new_value})
  #     {:ok, %Account{}}

  #     iex> update_account(account, %{field: bad_value})
  #     {:error, ...}

  # """
  # def update_account(%Account{} = account, attrs) do
  #   raise "TODO"
  # end

  # @doc """
  # Deletes a Account.

  # ## Examples

  #     iex> delete_account(account)
  #     {:ok, %Account{}}

  #     iex> delete_account(account)
  #     {:error, ...}

  # """
  # def delete_account(%Account{} = account) do
  #   raise "TODO"
  # end

  # @doc """
  # Returns a data structure for tracking account changes.

  # ## Examples

  #     iex> change_account(account)
  #     %Todo{...}

  # """
  # def change_account(%Account{} = account, _attrs \\ %{}) do
  #   raise "TODO"
  # end

  # alias Moz.Mozaic.Thread

  # @doc """
  # Returns the list of thread.

  # ## Examples

  #     iex> list_thread()
  #     [%Thread{}, ...]

  # """
  # def list_thread do
  #   raise "TODO"
  # end

  @doc """
  Gets a single thread.

  Raises if the Thread does not exist.

  ## Examples

      iex> get_thread!(123)
      %Thread{}

  """
  def get_thread!(id) do
    posts_query = from p in Moz.Post, order_by: [p.created_at]
    from(t in Moz.Thread,
      where: t.id == ^id,
      limit: 1,
      preload: [posts: ^posts_query],
      preload: [:forum]
    )
    |> Repo.one
  end

  # @doc """
  # Creates a thread.

  # ## Examples

  #     iex> create_thread(%{field: value})
  #     {:ok, %Thread{}}

  #     iex> create_thread(%{field: bad_value})
  #     {:error, ...}

  # """
  # def create_thread(attrs \\ %{}) do
  #   raise "TODO"
  # end

  # @doc """
  # Updates a thread.

  # ## Examples

  #     iex> update_thread(thread, %{field: new_value})
  #     {:ok, %Thread{}}

  #     iex> update_thread(thread, %{field: bad_value})
  #     {:error, ...}

  # """
  # def update_thread(%Thread{} = thread, attrs) do
  #   raise "TODO"
  # end

  # @doc """
  # Deletes a Thread.

  # ## Examples

  #     iex> delete_thread(thread)
  #     {:ok, %Thread{}}

  #     iex> delete_thread(thread)
  #     {:error, ...}

  # """
  # def delete_thread(%Thread{} = thread) do
  #   raise "TODO"
  # end

  # @doc """
  # Returns a data structure for tracking thread changes.

  # ## Examples

  #     iex> change_thread(thread)
  #     %Todo{...}

  # """
  # def change_thread(%Thread{} = thread, _attrs \\ %{}) do
  #   raise "TODO"
  # end
end
