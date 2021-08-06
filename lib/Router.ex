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
    # the home route
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, "./view/home.html")
  end

  get "/public/*_file" do
    #this is for get get the files
    conn |> send_file(200, Anonpost.Controllers.check404Files("." <> conn.request_path))
  end

  get "/board" do

    #we get the params
    params = QeryStr.decode(conn.query_string)
    #then we get the actual board
    board=params["board"]
    #and now we check if is on boards
    isOn = Anonpost.Controllers.isOnBoards?(board)
    # then we send a file with a template
    if isOn do
      Anonpost.Controllers.render(conn,"boards.eex",[board_title: board])
    else# or send a 404 response
      send_file(conn, 404, "./view/404.html")
    end
  end
  post "/board" do
    # i need to
    conn|>send_resp(200,Kernel.inspect(conn))
  end

  match _ do
    conn |> send_file(404, "./view/404.html")
  end
end
