defmodule MozWeb.MozComponents do
  use Phoenix.Component
  use Phoenix.VerifiedRoutes, router: MozWeb.Router, endpoint: MozWeb.Endpoint, statics: ~w(images)
  import MozWeb.Gettext
  alias Phoenix.LiveWeb.JS

  attr :user, Moz.User, required: false
  def top(assigns) do
    ~H"""
    <div class="flex items-center justify-between border-b border-zinc-100 py-3 text-sm">
      <div class="flex items-center gap-4">
        <a href="/">
          <img src={~p"/images/logo.svg"} width="36" />
        </a>
        <p class="bg-brand/5 text-brand rounded-full px-2 font-medium leading-6">
          logo
        </p>
      </div>
      <div class="flex items-center gap-4 font-semibold leading-6 text-zinc-900">
        <.user_info user={assigns[:user]} />
      </div>
    </div>
    <.nav_bar />
    """
  end

  def nav_bar(assigns) do
    ~H"""
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
      <input type="submit" />
    </.form>
    """
  end

  def user_nick(assigns, user) do
    ~H"""
    nick
    """
  end

  def logout_link(assigns) do
    ~H"""
    logout
    """
  end
end

