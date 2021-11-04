defmodule Anonpost.Controllers do
  alias Anonpost.Controllers.Response, as: Resp
  alias Anonpost.Validation, as: Valid
  alias Anonpost.Domain.Post, as: Post
  alias Anonpost.Database, as: DB

  @spec query_get_board(Plug.Conn.t()) :: Plug.Conn.t()
  def query_get_board(conn) do
    # we get the params

    params = conn.params
    # then we get the actual board
    board = params["board"]
    # and now we check if is on board
    isOn = Valid.isOnBoards?(board)
    publ = DB.get_publications(board)

    # then we send a file with a template
    # or send a 404 response
    if isOn do
      Resp.render(conn, "boards",
        board_title: board,
        req_url: "#{conn.request_path}?#{conn.query_string}",
        publications: publ,
        customCSSHeaders: ["index", "publicate", "boards"],
        customScriptHeaders: [],
        customScriptBody: ["canvasAnimation"]
      )
    else
      Resp.send_file(conn, 404, "./view/404.html")
    end
  end

  @moduledoc """
  this is for upload the posts
  """
  @spec upload(Plug.Conn.t()) :: Plug.Conn.t()
  def upload(conn) do
    board = conn.params["board"]
    params = Post.getAttr(conn, board)

    unless Enum.member?(Map.values(params), "") or !Valid.isOnBoards?(conn.params["board"]) do
      DB.upload_to_db(params)

      conn
      |> Resp.send_resp(200, "everything is okay")
    else
      conn
      |> Resp.send_file(404, "./view/404.html")
    end
  end

  @spec public_files(Plug.Conn.t()) :: Plug.Conn.t()
  def public_files(conn) do
    # this is for get get the files

    conn |> Resp.send_file(200, Valid.check404Files("." <> conn.request_path))
  end

  def get_post(conn) do
    params = conn.params

    # Gets the post of a specific board.
    post =
      DB.get_post(%{
        id: params["id"]
      })

    # Temporarily only responds if its correct.
    if post do
      Resp.render(conn, "posts",
        board: post["board"],
        id: post["_id"],
        title: post["title"],
        content: post["body"],
        username: post["username"],
        req_url: "#{conn.request_path}?#{conn.query_string}",
        customCSSHeaders: ["index", "publicate", "post"],
        customScriptHeaders: [],
        customScriptBody: []
      )
    else
      conn
      |> Resp.send_file(404, "./view/404.html")
    end
  end
end
