defmodule Anonpost do

  use Application
  require Logger
  @impl true
  def start(_type, _args) do

    children = [
      {Plug.Cowboy, scheme: :http, plug: Anonpost.SetupRouter, options: [port: 8080]}
    ]

    Logger.info("starting application at http://localhost:8080")
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
