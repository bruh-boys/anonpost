defmodule Anonpost.SetupRouter do
  use Plug.Router

  plug(:match)
  plug(:dispatch)



  get "/" do
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, "./view/home.html")
  end
  forward "/public" ,to: Anonpost.Static

#    match _ do#

#    conn
#    |> put_resp_content_type("text/html")
#    |> send_file(200, "./view/404.html")
#  end

end
