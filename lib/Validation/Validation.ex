defmodule Anonpost.Validation do
  @moduledoc """
  Im making the module for verify some stuff , like if the file exist or if the board is avaible

#a
  """
  @doc """
  This function only works for get the avaible boards on anonpost and thats all
  """
  def validboards(),
    do: %{
      "animals" => ["rats", "monkeys", "cats", "dogs"],
      "games" => ["minecraft", "warframe", "call_of_duty"],
      "languages" => ["español", "english"],
      "programming" => ["haskell", "elixir", "javascript", "typescript", "rust", "golang","cpp","java"],
      "technology" => ["robotic","IoT","crypto","systems","hardware","hacking"],
      "science" => ["math", "chemistry","physics"],
      "other"=>["random","genz","espressif_supremacy"]
    }

  @doc """
  this is for check if the board exists on valid boards

  """
  @spec isOnBoards?(binary) :: boolean
  def isOnBoards?(board), do: Enum.member?(Map.values(validboards()) |> List.flatten(), board)

  @doc """
  if the file exist is going to send a the actual path , if it doesnt its going to send the 404.html file
  """
  def check404Files(path) do
    if File.exists?(path), do: path, else: "view/404.html"
  end
end
