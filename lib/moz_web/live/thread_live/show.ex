defmodule MozWeb.ThreadLive.Show do
  use MozWeb, :live_view

  alias Moz.Mozaic
  import MozWeb.MozComponents

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    thread = Mozaic.get_thread!(id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action, thread))
     |> assign(:thread, thread)}
  end

  defp page_title(:show, thread) do
    thread.title <> " | Mosiaic forum"
  end
end
