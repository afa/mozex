defmodule MozWeb.UserLive.Show do
  use MozWeb, :live_view
  import MozWeb.MozComponents

  alias Moz.Users

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    user = Users.get_user!(id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, user)
     |> assign(:item, %{item: [%{title: user.name}]})
    }
  end

  defp page_title(:show), do: "Show User"
end
