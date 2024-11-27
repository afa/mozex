defmodule MozWeb.UserHook do
  use Phoenix.LiveView
  require Moz.Accounts

  def on_mount(:logged_in, _params, session, socket) do
  # def on_mount(:logged_in, _params, %{"moz_token" => token} = session, socket) do
    if connected?(socket) do
      # Moz.User.subscribe(current_user_id)
    end
    user = build_current_user(session, socket)
    socket =
      socket
      |> assign_new(:current_user, fn -> build_current_user(session, socket) end)
      |> attach_hook(:current_user_subscription, :handle_info, &info/2)
    
    {:cont, socket}
  end

  defp info(
         {:user_change, %{id: id} = user},
         %{assigns: %{current_user: %{id: id}}} = socket
       ) do
    {:cont, assign(socket, :current_user, user)}
  end

  defp info(_message, socket), do: {:cont, socket}

  defp build_current_user(session, socket) do
    connect_params = get_connect_params(socket) || %{}
    attrs = connect_params["moz_token"] || session["moz_token"]
    IO.inspect session
    user = case session do
      %{"moz_token" => %{"" => _}} ->
        %Moz.User{id: nil, name: "Guest"}
      %{"moz_token" => map} when is_map(map) and map_size(map) > 0 ->
        Map.keys(map)
        |> Enum.take(1)
        |> hd()
        |> Moz.Accounts.user_from_token()
      %{} ->
        %Moz.User{id: nil, name: "Guest"}
    end
    # %{"current_user_id" => current_user_id} = session
    # user = %{User.new() | id: current_user_id}


    # changeset = User.changeset(user, attrs)

    # case Livebook.Users.update_user(changeset) do
      # {:ok, user} -> user
      # {:error, _changeset} -> user
    # end
  end
end
# defmodule LivebookWeb.UserHook do
#  import Phoenix.LiveView

#  alias Livebook.Users.User

#  def on_mount(:default, _params, %{"current_user_id" => current_user_id} = session, socket) do
#    if connected?(socket) do
     # Livebook.Users.subscribe(current_user_id)
#    end

#    socket =
#      socket
#      |> assign_new(:current_user, fn -> build_current_user(session, socket) end)
#      |> attach_hook(:current_user_subscription, :handle_info, &info/2)

#    {:cont, socket}
#  end

#  defp info(
#         {:user_change, %{id: id} = user},
#         %{assigns: %{current_user: %{id: id}}} = socket
#       ) do
#    {:cont, assign(socket, :current_user, user)}
#  end

#  defp info(_message, socket), do: {:cont, socket}

#  # Builds `Livebook.Users.User` using information from
#  # session and socket.
#  #
#  # Uses `user_data` from socket `connect_params` as initial
#  # attributes if the socket is connected. Otherwise uses
#  # `user_data` from session.
#  defp build_current_user(session, socket) do
#    %{"current_user_id" => current_user_id} = session
#    user = %{User.new() | id: current_user_id}

#    connect_params = get_connect_params(socket) || %{}
#    attrs = connect_params["user_data"] || session["user_data"] || %{}

#    changeset = User.changeset(user, attrs)

#    case Livebook.Users.update_user(changeset) do
#      {:ok, user} -> user
#      {:error, _changeset} -> user
#    end
#  end
#end
