defmodule MozWeb.ForumLive.Index do
  use MozWeb, :live_view

  alias Moz.Mozaic
  alias Moz.Forum

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :forum_collection, Mozaic.list_forum())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Forum")
    |> assign(:forum, Mozaic.get_forum!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Forum")
    |> assign(:forum, %Forum{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Forum")
    |> assign(:forum, nil)
  end

  @impl true
  def handle_info({MozWeb.ForumLive.FormComponent, {:saved, forum}}, socket) do
    {:noreply, stream_insert(socket, :forum_collection, forum)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    forum = Mozaic.get_forum!(id)
    {:ok, _} = Mozaic.delete_forum(forum)

    {:noreply, stream_delete(socket, :forum_collection, forum)}
  end
end
