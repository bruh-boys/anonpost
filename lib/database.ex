defmodule Anonpost.Database do
  @moduledoc """
    we are using mongodb for this
    this is running in local so if u want to deploy this maybe it could be a little bit insecure
  """
  defp get_connection() do
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27017/anonpost")
    conn
  end

  def upload_to_db(publ, board) do
    conn = get_connection()
    pubMap = struct_to_map(publ)
    IO.inspect(pubMap)
    conn |> Mongo.insert_one!(board, pubMap)
  end

  defp struct_to_map(publ) do
    publ |> Map.from_struct
  end
end
