defmodule MozWeb.ForumLive.FormComponent do
  use MozWeb, :live_component

  alias Moz.Mozaic

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage forum records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="forum-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Forum</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{forum: forum} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Mozaic.change_forum(forum))
     end)}
  end

  @impl true
  def handle_event("validate", %{"forum" => forum_params}, socket) do
    changeset = Mozaic.change_forum(socket.assigns.forum, forum_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"forum" => forum_params}, socket) do
    save_forum(socket, socket.assigns.action, forum_params)
  end

  defp save_forum(socket, :edit, forum_params) do
    case Mozaic.update_forum(socket.assigns.forum, forum_params) do
      {:ok, forum} ->
        notify_parent({:saved, forum})

        {:noreply,
         socket
         |> put_flash(:info, "Forum updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_forum(socket, :new, forum_params) do
    case Mozaic.create_forum(forum_params) do
      {:ok, forum} ->
        notify_parent({:saved, forum})

        {:noreply,
         socket
         |> put_flash(:info, "Forum created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
