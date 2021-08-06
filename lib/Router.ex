defmodule Anonpost.Router do
  use Plug.Router
  alias Plug.Conn.Query, as: QeryStr
  plug(:match)
  plug(:dispatch)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart],
    pass: ["text/*"]
  )

  use Plug.ErrorHandler

  get "/" do

    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, "./view/home.html")
  end

  get "/public/*_file" do
    conn |> send_file(200, Anonpost.Controllers.check404Files("." <> conn.request_path))
  end

  get "/board" do
    params = QeryStr.decode(conn.query_string)
    board=params["board"]
    isOn = Anonpost.Controllers.isOnBoards?(board)

    if isOn do
      Anonpost.Controllers.render(conn,"boards.eex",[board_title: board])
    else
      send_file(conn, 404, "./view/404.html")
    end
  end

  match _ do
    conn |> send_file(404, "./view/404.html")
  end
end
