defmodule AnonpostTest do
  use ExUnit.Case
  doctest Anonpost

  test "greets the world" do
    assert Anonpost.hello() == :world
  end
end
