defmodule Anonpost.Validation do
  def validboards(),
    do: %{
      "animals" => "a",
      "games" => "d",
      "languages" => "b",
      "programming" => "a",
      "technology" => "b",
      "science" => "c"
    }

  def isOnBoards?(board), do: Enum.member?(Map.keys(validboards()), board)

  def check404Files(path) do
    if File.exists?(path), do: path, else: "view/404.html"
  end
end
