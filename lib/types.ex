defmodule Anonpost.Types do
  defmacro __using__(_) do
  end

  defmodule Publ do
    defstruct _id: "000000000000",
              username: "anon",
              title: "404 not found",
              body: "404 not found",
              comments: []
  end

  def get_request_attrs(conn) do
    params = conn.params
    username = String.trim(params["username"])

    %Publ{
      _id: BSON.ObjectId.encode!(Mongo.IdServer.new()),
      username: (if username == "" , do: "anon" ,else:  username),

      title: params["title"],
      body: params["body"]
    }
  end
end
