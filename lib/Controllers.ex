defmodule Anonpost.Controllers do
  @spec check404Files(binary) :: binary

  def check404Files(path) do
    if File.exists?(path), do: path, else: "view/404.html"
  end
end
