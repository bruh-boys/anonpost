defmodule Anonpost.Database do
  use Anonpost.Types
  @moduledoc """
    we are using mongodb for this
    this is running in local so if u want to deploy this maybe it could be a little bit insecure
  """
  def get_connection() do

    {:ok,conn}=Mongo.start_link(url: "mongodb://localhost:27017/anonpost")
    conn
  end

  @spec upload_to_databse(Publ) :: any
  def upload_to_databse(publ) do
    IO.inspect(publ)
    #conn=get_connection()my
    #conn|>Mongo.update_one!(Publ[""])

  end

end
