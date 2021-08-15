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
    # then we send a file with a template
    # or send a 404 response
    if isOn do
      Resp.render(conn, "boards",
        board_title: board,
        req_url: "#{conn.request_path}?#{conn.query_string}",
        publications: DB.get_publications(board),
        customCSSHeaders: ["index", "publicate"],
        customScriptHeaders: [],
        customScriptBody: []
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
    params = Post.getAttr(conn)

    unless Enum.member?(Map.values(params), "") or !Valid.isOnBoards?(conn.params["board"]) do
      DB.upload_to_db(params, board)

      conn
      |> Resp.send_resp(200, "everything is okay")
    else
      conn
      |> Resp.send_file(404, "./view/404.html")
    end
  end


  def public_files(conn) do
    # this is for get get the files
    conn
    |> Resp.send_file(200, Valid.check404Files("." <> conn.request_path))
  end

  def getPost(conn) do
    params = conn.params

    # Gets the post of a specific board.
    post =
      DB.getPost(%{
        board: params["board"],
        id: params["id"]
      })

    # Temporarily only responds if its correct.
    if post do
      conn
      |> Resp.send_resp(200, "correct")
    else
      conn
      |> Resp.send_file(404, "./view/404.html")
    end
  end
end
