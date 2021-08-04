defmodule Anonpost.Static do
  use Plug.Builder

  plug(Plug.Static,
    at: "/public",
    from: {:app_name, "public"}
  )
  plug :not_found

  @spec not_found(Plug.Conn.t(), any) :: Plug.Conn.t()
  def not_found(conn, _) do
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, "./view/404.html")
  end
end
