defmodule Anonpost.Controllers.Render do
  @template_dir "templates"






  def render(%{status: status} = conn, template, assigns \\ []) do
    body = @template_dir
      |> Path.join(template <> ".eex")
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)

    renderedFile = @template_dir
      |> Path.join("main.eex")
      |> EEx.eval_file([template: body] ++ assigns)

    Plug.Conn.send_resp(conn, status || 200, renderedFile)
  end
end
