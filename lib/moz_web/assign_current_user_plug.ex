defmodule MozWeb.AssignCurrentUserPlug do
  import Plug.Conn
  
  def init(_) do
    %{}
  end

  def call(conn, _opts) do
    conn = fetch_cookies(conn)

    # cookie = conn.cookies["user_cookie"]
    cookie = conn.cookies["moz_token"]

    user_details = case cookie do
      nil -> 
        %Moz.User{id: nil, name: "Guest"}
        # %{user_name: "Anonymous",  user_id: nil}
      _ ->
        data = Plug.Conn.Query.decode(cookie)
        data
    end

    conn
    |> put_session(:moz_token, user_details) # Makes it available in LiveView
    |> assign(:moz_token, user_details) # Makes it available in traditional controllers etc
    # |> put_session(:current_user, user_details) # Makes it available in LiveView
    # |> assign(:current_user, user_details) # Makes it available in traditional controllers etc
  end

end
