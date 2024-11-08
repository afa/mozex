defmodule Moz.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MozWeb.Telemetry,
      Moz.Repo,
      {DNSCluster, query: Application.get_env(:moz, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Moz.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Moz.Finch},
      # Start a worker by calling: Moz.Worker.start_link(arg)
      # {Moz.Worker, arg},
      # Start to serve requests, typically the last entry
      MozWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Moz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MozWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
