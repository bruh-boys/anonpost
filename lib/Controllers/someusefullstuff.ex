defmodule Anonpost.Controllers.Stuff do
  @template_dir "templates"

  def boards(), do: ["haskell", "elixir", "github", "programming", "bruh boys"]

  def isOnBoards?(board), do: Enum.member?(boards(), board)

  @spec check404Files(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) ::
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
  @doc """
    this is for check if the file exists in the public folder
  """
  def check404Files(path) do
    if File.exists?(path), do: path, else: "view/404.html"
  end

  @spec render(
          Plug.Conn.t(),
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            ),
          keyword
        ) :: Plug.Conn.t()
  @doc """
  this is going to render a EEx file , with arguments
  """
  def render(%{status: status} = conn, template, assigns \\ []) do
    body =
      @template_dir
      |> Path.join(template)
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)

    Plug.Conn.send_resp(conn, status || 200, body)
  end
end
