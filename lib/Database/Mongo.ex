defmodule Anonpost.Database.MongoDB do
  @moduledoc """
    we are using mongodb for this
    this is running in local so if u want to deploy this maybe it could be a little bit insecure
  """
  @posts_storage "post"
  defp get_connection() do
    # TODO: use a .env file for loading mongo uri
    # change "localhost" for "mongodb" when using docker
    {:ok, conn} = Mongo.start_link(url: "mongodb://localhost:27017/anonpost")
    conn
  end

  def upload_to_db(publ) do
    conn = get_connection()
    IO.inspect(publ)

    conn
    |> Mongo.insert_one!(
      @posts_storage ,
      publ |> Map.put(:_id, BSON.ObjectId.encode!(Mongo.IdServer.new()))
    )
  end

  def get_publications(board) do
    get_connection()
    |> Mongo.aggregate(@posts_storage , [
      %{
        "$match"=>%{
          board: board,
          replygin_to: "no one"
        }
      },
      %{
        "$sort"=>%{
          time: -1
        }
      },
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

  # Gets the post of a specific board.

  def get_post(%{ id: id}) do
    get_connection()
    |> Mongo.find_one(@posts_storage , %{ _id: id})
  end

  # If first function fails, this is executed and returns nil.
end
