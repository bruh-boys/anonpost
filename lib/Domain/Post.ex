defmodule Anonpost.Domain.Post do
  defmodule Publ do
    defstruct username: "anon",
              title: "404 not found",
              body: "404 not found",
              comments: []
  end

  def getAttr(conn) do
    params = conn.params
    username = String.trim(params["username"])

    %Publ{
      username: if(username == "", do: "anon", else: username),
      title: params["title"],
      body: params["body"]
    }
  end
  def struct_to_map(publ) do
    publ |> Map.from_struct()
  end

end
