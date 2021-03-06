defmodule Anonpost.Database do
  alias Anonpost.Database.MongoDB, as: DB
  alias Anonpost.Domain.Post, as: Post

  @moduledoc """
    we are using mongodb for this
    this is running in local so if u want to deploy this maybe it could be a little bit insecure
  """

  def upload_to_db(publ) do
    Post.struct_to_map(publ)|> DB.upload_to_db()
  end

  def get_publications(board) do

    DB.get_publications(board)
  end

  # Gets the post of a specific board.
  def get_post(%{ id: id}) when  id != nil do
    DB.get_post(%{ id: id})
  end

  # If first function fails, this is executed and returns nil.
  def get_post(_), do: nil
end
