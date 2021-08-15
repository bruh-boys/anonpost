defmodule Anonpost.Validation do
  def validboards(),
    do: %{
      "animals" => ["rats","monkeys"],
      "games" => ["minecraft","warframe"],
      "languages" => ["spanish","english"],
      "programming" => ["haskell","elixir"],
      "technology" => ["robotic"],
      "science" => ["math","chemistry"]
    }

  @spec isOnBoards?(binary) :: boolean
  def isOnBoards?(board), do: Enum.member?(Map.values(validboards()) |> List.flatten(), board)


  def check404Files(path) do
    if File.exists?(path), do: path, else: "view/404.html"
  end
end
