defmodule MozWeb.ForumLive.Show do
  use MozWeb, :live_view

  alias Moz.Mozaic

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:forum, Mozaic.get_forum_with_tops!(id, 3))}
  end

  defp page_title(:show), do: "Show Forum"
  defp page_title(:edit), do: "Edit Forum"
end
