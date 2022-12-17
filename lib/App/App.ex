defmodule Anonpost.App do
#
  use Application
  require Logger
  @impl true
  def start(_type, _args) do
    port=System.get_env("port","8080")

    children = [
      {Plug.Cowboy, scheme: :http, plug: Anonpost.Router, options: [port: String.to_integer(port)]}
    ]

    Logger.info("starting application at http://localhost:8080")
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
