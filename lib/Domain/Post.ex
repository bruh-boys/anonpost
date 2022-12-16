defmodule Anonpost.Domain.Post do
  defmodule Publ do
    defstruct replygin_to: "no one",
              board: "",
              username: "anon",
              title: "404 not found",
              body: "404 not found",
              time: DateTime.utc_now |>DateTime.to_unix,
              comments: []
  end
#æa
  def getAttr(conn,board) do
    params = conn.params
    username = String.trim (params["username"])

    %Publ{
      board: board,
      username: if(username == "", do: "anon", else: username),
      title: params["title"],
      body: params["body"],
      time: DateTime.utc_now |>DateTime.to_unix
    }
  end
  def struct_to_map(publ) do
    publ |> Map.from_struct()
  end

end
