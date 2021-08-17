defmodule Anonpost.MixProject do
  use Mix.Project

  def project do
    [
      app: :anonpost,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end


  def application do
    [
      extra_applications: extra_applications(Mix.env(), [:logger]),
      mod: {Anonpost.App, []}
    ]
  end

  defp extra_applications(:dev, default), do: default ++ [:remix]
  defp extra_applications(_, default), do: default

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:mongodb, "~> 0.5.1"},
      {:remix, "~> 0.0.1", only: :dev}
    ]
  end
end
