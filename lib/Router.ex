defmodule Anonpost.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)
  use Plug.ErrorHandler
  get "/" do
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, "./view/home.html")
  end

  get "/public/*_file" do
    conn |> send_file(200,Anonpost.Controllers.check404Files( "." <> conn.request_path))
  end



  match _ do
    conn |> send_file(404, "./view/404.html")
  end
end
