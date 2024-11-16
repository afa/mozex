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
  def get_forum_with_tops!(id, size) do
    from(f in Forum,
      where: f.id == ^id,
      preload: [:children],
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

  @doc """
  Returns a data structure for tracking forum changes.

  ## Examples

      iex> change_forum(forum)
      %Todo{...}

  """
  def change_forum(%Forum{} = forum, _attrs \\ %{}) do
    raise "TODO"
  end
end
