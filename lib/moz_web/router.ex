defmodule MozWeb.Router do
  use MozWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    # plug :assign_current_user
    plug MozWeb.AssignCurrentUserPlug
    plug :fetch_live_flash
    plug :put_root_layout, html: {MozWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", MozWeb do
    # pipe_through [:browser, :assign_current_user]
    pipe_through :browser
    post "/login", AccountController, :login
    post "/logout", AccountController, :logout
  end
  live_session :logged_in, on_mount: [{MozWeb.UserHook, :logged_in}] do
    scope "/", MozWeb do
      pipe_through :browser
      live "/user", UserLive.Index, :index

      live "/user/:id", UserLive.Show, :show

      live "/forum", ForumLive.Index, :index
      live "/forum/:id", ForumLive.Show, :show

      live "/", DashboardLive.Index, :index

      # live "/thread", ThreadLive.Index, :index
      # live "/thread/new", ThreadLive.Index, :new
      # live "/thread/:id/edit", ThreadLive.Index, :edit

      live "/thread/:id", ThreadLive.Show, :show
      # live "/thread/:id/show/edit", ThreadLive.Show, :edit
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", MozWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:moz, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: MozWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
