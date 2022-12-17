defmodule Anonpost.Router do
  use Plug.Router
#
  alias Anonpost.Controllers.Response , as: Resp
  alias Anonpost.Controllers, as: Controll
  alias Anonpost.Validation, as: Boards

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart]
  )

  plug(:match)
  plug(:dispatch)

  use Plug.ErrorHandler

  get "/" do
    conn
      |> Resp.render("home",
      customCSSHeaders: ["home"],
      customScriptHeaders: [],
      customScriptBody: [],
      boards: Boards.validboards()
    )
  end

  get "/public/*_file" do
    Controll.public_files(conn)
  end

  get "/board" do
    Controll.query_get_board(conn)
  end

  post "/board" do
    Controll.upload(conn)
  end

  get "/post" do
    Controll.get_post(conn)
  end

  match _ do
    IO.puts(conn.request_path)
    conn |> send_file(404, "./view/404.html")
  end
end
