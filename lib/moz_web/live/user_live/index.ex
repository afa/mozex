defmodule MozWeb.UserLive.Index do
  use MozWeb, :live_view

  alias Moz.Users
  alias Moz.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :users, Users.list_user())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :login, _params) do
    socket
    |> assign(:page_title, "Login")
  end
  # defp apply_action(socket, :edit, %{"id" => id}) do
  #   socket
  #   |> assign(:page_title, "Edit User")
  #   |> assign(:user, Users.get_user!(id))
  # end

  # defp apply_action(socket, :new, _params) do
  #   socket
  #   |> assign(:page_title, "New User")
  #   |> assign(:user, %User{})
  # end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User")
    |> assign(:users, Users.list_user())
    |> assign(:user, nil)
  end

  @impl true
  def handle_info({MozWeb.UserLive.FormComponent, {:saved, user}}, socket) do
    {:noreply, stream_insert(socket, :user_collection, user)}
  end

  @impl true
  def handle_event("login", params, %{live_action: :login} = socket) do
    {:noreply, {}}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user = Users.get_user!(id)
    {:ok, _} = Users.delete_user(user)

    {:noreply, stream_delete(socket, :user_collection, user)}
  end
end
