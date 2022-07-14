defmodule SelectMultiple.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SelectMultiple.Repo,
      # Start the Telemetry supervisor
      SelectMultipleWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SelectMultiple.PubSub},
      # Start the Endpoint (http/https)
      SelectMultipleWeb.Endpoint
      # Start a worker by calling: SelectMultiple.Worker.start_link(arg)
      # {SelectMultiple.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SelectMultiple.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SelectMultipleWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
