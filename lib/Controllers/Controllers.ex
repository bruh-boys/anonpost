defmodule Anonpost.Controllers do

  alias Plug.Conn.Query, as: Query
  alias Anonpost.Controllers.Stuff, as: Stuff


  def query_get_board(conn) do
    # we get the params
    params = Query.decode(conn.query_string)
    # then we get the actual board
    board = params["board"]
    # and now we check if is on board

    isOn =Stuff.isOnBoards?(board)
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

  def public_files(conn) do
    # this is for get get the files
    conn |> Plug.Conn.send_file(200, Stuff.check404Files("." <> conn.request_path))
  end
end
