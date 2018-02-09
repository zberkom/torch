defmodule Torch.MixProject do
  use Mix.Project

  def project do
    [
      app: :torch,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      compilers: [:phoenix] ++ Mix.compilers(),
      name: "Torch",
      description: "Rapid admin generator for Phoenix",
      package: package(),
      docs: docs(),
      deps: deps()
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
      {:phoenix, "~> 1.3"},
      {:phoenix_html, "~> 2.10"}
    ]
  end

  defp package do
    [
      maintainers: ["Infinite Red"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/infinitered/torch"
      },
      files: ~w(assets lib priv webpack.config.js mix.exs package.json README.md)
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end
end