defmodule MozWeb.ThreadLive.Index do
  use MozWeb, :live_view

  alias Moz.Mozaic
  alias Moz.Thread

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :thread_collection, Mozaic.list_thread())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Thread")
    |> assign(:thread, Mozaic.get_thread!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Thread")
    |> assign(:thread, %Thread{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Thread")
    |> assign(:thread, nil)
  end

  @impl true
  def handle_info({MozWeb.ThreadLive.FormComponent, {:saved, thread}}, socket) do
    {:noreply, stream_insert(socket, :thread_collection, thread)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    thread = Mozaic.get_thread!(id)
    {:ok, _} = Mozaic.delete_thread(thread)

    {:noreply, stream_delete(socket, :thread_collection, thread)}
  end
end
