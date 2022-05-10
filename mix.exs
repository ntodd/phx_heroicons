defmodule Heroicons.MixProject do
  use Mix.Project

  def project do
    [
      app: :phx_heroicons,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [
        description: "Heroicons Components for Phoenix LiveView",
        licenses: ["MIT"],
        links: %{github: "https://github.com/ntodd/phx_heroicons"}
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_live_view, "~> 0.17.9"},
      {:req, "~> 0.2.2", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
