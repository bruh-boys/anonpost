defmodule Anonpost.Types do
  defmacro __using__(_)do

  end
  defmodule Publ do
    defstruct username: "anon",
              title: "404 not found",
              body: "404 not found",
              comments: []
  end

  def get_request_attrs(conn) do
    params = conn.params

    %Publ{username: params["username"], title: params["title"], body: params["body"]}


  end
end
