defmodule MozWeb.MozComponents do
  use Phoenix.Component
  use Phoenix.VerifiedRoutes, router: MozWeb.Router, endpoint: MozWeb.Endpoint, statics: ~w(images)
  import MozWeb.Gettext
  alias Phoenix.LiveWeb.JS


  attr :thread, Moz.Thread, required: true
  def thread_breadcrumb(assigns) do
    ~H"""
    <.breadcrumb forum={assigns.thread.forum} />
    <span>
      /
    </span>
    <span>
      <%= assigns.thread.title %>
    </span>
    """
  end

  attr :forum, Moz.Forum, required: true
  def breadcrumb(assigns) do
    ~H"""
      <.breadcrumb forum={Moz.Mozaic.load_forum_parent(assigns.forum)} :if={assigns.forum.parent_id}/>
      <span :if={assigns.forum.parent_id}>
        /
      </span>
      <span>
        <a navigate={~p"/forum/#{assigns.forum}"}>
          <%= assigns.forum.title %>
        </a>
      </span>
    """
  end

  attr :user, Moz.User, required: true
  # attr :forums, :list, required: true
  def forums_on_main(assigns) do
    # list of root forums, last posted thread (title, uname, last comment date)
    # for each top 3 child forums
    list = Moz.Mozaic.list_forums_with_tops!(nil, 3)
    ~H"""
    <div class="space-y-4">
      <div :for={forum <- list}>
        <div class="font-medium text-lg">
          <.link navigate={~p"/forum/#{forum}"}><%= forum.title_clean %></.link>
        </div>
        <div class="py-2 font-small text-xs">
          <%= forum.description_clean %>
        </div>
        <% ch = forum.children |> Enum.take(5) %>
        <div :for={ f <- ch } clsdd="font-small text-sm">
          <.link class="px-4" navigate={~p"/forum/#{f}"}><%= f.title_clean %></.link>
        </div>
      </div>
    </div>
    """
  end

  attr :user, Moz.User, required: true
  def top(assigns) do
    ~H"""
    <div class="flex items-center justify-between border-b border-zinc-100 py-3 text-sm">
      <div class="flex items-center gap-4">
        <a href="/">
          <img src={~p"/images/logo.svg"} width="36" />
        </a>
        <p class="bg-brand/5 text-brand rounded-full px-2 font-medium leading-6">
          Mozaic forum
        </p>
        <p>
          Ex cinere surgo
        </p>
      </div>
      <div class="flex items-center gap-4 font-semibold leading-6 text-zinc-900">
        <.user_info user={assigns[:user]} />
      </div>
    </div>
    <.nav_bar user={@user}/>
    """
  end

  attr :user, Moz.User, required: true
  def nav_bar(assigns) do
    ~H"""
    <.link navigate={~p"/forum"}>Forums</.link>
    <.link :if={Moz.Policy.can?(@user, :users)} navigate={~p"/user"}>Users</.link>
    """
  end

  def user_info(assigns) do
    case assigns do
      %{user: %Moz.User{id: nil}} ->
        login_link(assigns)
      %{user: user} ->
        ~H"""
        <%= user_nick(assigns, user) %>
        <%= logout_link(assigns) %>
        """
      %{} ->
        login_link(assigns)
    end
  end

  def login_link(assigns) do
    ~H"""
    <.form :let={form} action={~p"/login"} for={%{}} method="post">
      <input type="text" name="login" />
      <input type="password" name="password" />
      <input type="submit" value="Login"/>
    </.form>
    """
  end

  defp user_nick(assigns, user) do
    ~H"""
      <%= user.name %>
    """
  end

  def logout_link(assigns) do
    ~H"""
    <.form :let={form} action={~p"/logout"} for={%{}} method="post">
      <input type="submit" value="Logout" />
    </.form>
    """
  end
end

