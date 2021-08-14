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

  def get_publications(board) do
    get_connection()
    |> Mongo.aggregate(board, [
      %{
        "$project" => %{
          comments: %{
            "$size" => "$comments"
          },
          title: "$title",
          username: "$username"
        }
      }
    ])
    |> Enum.to_list()
  end

  defp struct_to_map(publ) do
    publ |> Map.from_struct()
  end

  # Gets the post of a specific board.
  def getPost(%{board: board, id: id}) when board != nil and id != nil do
    get_connection()
      |> Mongo.find_one(board, %{_id: id})
  end

  # If first function fails, this is executed and returns nil.
  def getPost(%{}), do: nil
end
