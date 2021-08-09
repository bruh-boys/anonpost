defmodule Anonpost.Controllers do
  alias Anonpost.Controllers.Stuff, as: Stuff
  alias Anonpost.Types, as: Types
  alias Anonpost.Database, as: DB
  @spec query_get_board(Plug.Conn.t()) :: Plug.Conn.t()
  def query_get_board(conn) do
    # we get the params

    params = conn.params
    # then we get the actual board
    board = params["board"]
    # and now we check if is on board

    isOn = Stuff.isOnBoards?(board)
    # then we send a file with a template
    # or send a 404 response
    if isOn do
      Stuff.render(conn, "boards.eex",
        board_title: board,
        req_url: "#{conn.request_path}?#{conn.query_string}"
      )
    else
      Plug.Conn.send_file(conn, 404, "./view/404.html")
    end
  end

  @moduledoc """
  this is for upload the posts
  """
  @spec upload(Plug.Conn.t()) :: Plug.Conn.t()
  def upload(conn) do

    board=conn.params["board"]
    params=Types.get_request_attrs(conn)
    unless Enum.member?(Map.values(params), "") or !Stuff.isOnBoards?(conn.params["board"]) do
      IO.inspect(params)

      DB.upload_to_db(params,board)

      conn |> Plug.Conn.send_resp(200, "everything is okay")
    else
      conn |> Plug.Conn.send_file(404, "./view/404.html")
    end
  end

  @spec public_files(Plug.Conn.t()) :: Plug.Conn.t()
  def public_files(conn) do
    # this is for get get the files
    conn |> Plug.Conn.send_file(200, Stuff.check404Files("." <> conn.request_path))
  end
end
