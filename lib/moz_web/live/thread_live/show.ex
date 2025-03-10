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
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:thread, Mozaic.get_thread!(id))}
  end

  defp page_title(:show), do: "Show Thread"
  defp page_title(:edit), do: "Edit Thread"
end
