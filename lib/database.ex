defmodule Anonpost.Database do
  @moduledoc """
    we are using mongodb for this
    this is running in local so if u want to deploy this maybe it could be a little bit insecure
  """
  def get_connection() do
    {:ok,conn}=Mongo.start_link(url: "mongodb://localhost:27017/anonpost")
    conn
  end


end
