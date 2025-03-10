defmodule MozWeb.DashboardLive.Index do
  use MozWeb, :live_view
  import MozWeb.MozComponents

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

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Dashboard")
    |> assign(:dashboard, nil)
  end

  # @impl true
  # def handle_info({MozWeb.DashboardLive.FormComponent, {:saved, dashboard}}, socket) do
  #   {:noreply, stream_insert(socket, :dashboard_collection, dashboard)}
  # end
end
