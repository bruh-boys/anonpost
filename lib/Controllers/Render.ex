defmodule Anonpost.Controllers.Response do
  alias Plug.Conn, as: Conn

  @template_dir "templates"
 @moduledoc """
 This module it works for made it more easy to maintain
 and change the frameworks and stuff
 `send_resp` and `send_file` are only for made more easy that
 and render its for render the EEx files.
 besides that i have nothing to say
 """
  @spec send_resp(Plug.Conn.t(), integer, binary) :: Plug.Conn.t()
  def send_resp(conn, status, value) do
    conn |> Conn.send_resp(status, value)
  end

  @spec send_file(Plug.Conn.t(), integer, binary) :: Plug.Conn.t()
  def send_file(conn, status, path) do
    conn |> Conn.send_file(status, path)
  end

  @spec render(Plug.Conn.t(), binary, keyword) :: Plug.Conn.t()
  def render(%{status: status} = conn, template, assigns \\ []) do
    body =
      @template_dir
      |> Path.join(template <> ".eex")
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)

    renderedFile =
      @template_dir
      |> Path.join("index.eex")
      |> EEx.eval_file([template: body] ++ assigns)

    Plug.Conn.send_resp(conn, status || 200, renderedFile)
  end
end
