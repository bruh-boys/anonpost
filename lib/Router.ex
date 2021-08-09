defmodule Anonpost.Router do
  use Plug.Router

  alias Anonpost.Controllers, as: Controll

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart]
  )

  plug(:match)
  plug(:dispatch)

  use Plug.ErrorHandler

  get "/" do
    # the home route
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, "./view/home.html")
  end

  get "/public/*_file" do
    Controll.public_files(conn)
  end

  get "/board" do
    Controll.query_get_board(conn)
  end

  post "/board" do

    unless Enum.member?(Map.values(conn.params), "") do
      Anonpost.Types.get_request_attrs(conn)
      conn |> send_resp(200, "everything is okay")
    else
      conn |> send_file(404, "./view/404.html")
    end
  end

  match _ do
    conn |> send_file(404, "./view/404.html")
  end
end
