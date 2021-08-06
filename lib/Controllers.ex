defmodule Anonpost.Controllers do
  @spec check404Files(binary) :: binary
  @template_dir  "templates"
  def boards(), do:  ["haskell","elixir","github","programming","bruh boys"]

  def isOnBoards?(board) ,do: Enum.member?(boards(),board)


  @doc """
    this is for check if the file exists in the public folder
  """
  def check404Files(path) do
    if File.exists?(path), do: path, else: "view/404.html"
  end
  @doc """
  this is going to render a EEx file , with arguments
  """
  def render(%{status: status} = conn, template, assigns \\ []) do
    body =
      @template_dir
      |> Path.join(template)
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)

    Plug.Conn.send_resp(conn, (status || 200), body)
  end
end
