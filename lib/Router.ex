defmodule Anonpost.Router do

  alias Plug.Conn.Query , as: Query
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart]

  )

  use Plug.ErrorHandler

  get "/" do
    # the home route
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, "./view/home.html")
  end

  get "/public/*_file" do
    # this is for get get the files
    conn |> send_file(200, Anonpost.Controllers.check404Files("." <> conn.request_path))
  end

  get "/board" do
    # we get the params
    params = Query.decode(conn.query_string)
    # then we get the actual board
    board = params["board"]
    # and now we check if is on boards
    isOn = Anonpost.Controllers.isOnBoards?(board)
    # then we send a file with a template
    # or send a 404 response
    if isOn do
      Anonpost.Controllers.render(conn, "boards.eex",
        board_title: board,
        req_url: "#{conn.request_path}?#{conn.query_string}"
      )
    else
      send_file(conn, 404, "./view/404.html")
    end
  end

  post "/board" do
    # i need to

    IO.inspect(conn)
    IO.inspect(conn.query_params)
    IO.inspect(conn.body_params)
    Plug.Parsers.URLENCODED
    conn |> send_resp(200, Kernel.inspect(conn.params))
  end

  match _ do
    conn |> send_file(404, "./view/404.html")
  end
end
