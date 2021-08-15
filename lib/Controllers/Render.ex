defmodule Anonpost.Controllers.Response do
  alias Plug.Conn, as: Conn
  @template_dir "templates"

  def send_resp(conn,status,value) do
    conn|>Conn.send_resp(status,value)
  end
  def send_file(conn,status,path)do
    conn|>Conn.send_file(status,path)
  end
  def render(%{status: status} = conn, template, assigns \\ []) do
    body =
      @template_dir
      |> Path.join(template <> ".eex")
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)

    renderedFile =
      @template_dir
      |> Path.join("main.eex")
      |> EEx.eval_file([template: body] ++ assigns)

    Plug.Conn.send_resp(conn, status || 200, renderedFile)
  end
end
