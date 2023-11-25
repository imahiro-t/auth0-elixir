defmodule Auth0Api.MixProject do
  use Mix.Project

  @description "Management API for Auth0"
  @source_url "https://github.com/imahiro-t/auth0-elixir"

  def project do
    [
      app: :auth0_api,
      version: "1.6.0",
      elixir: "~> 1.8",
      name: "Auth0Api",
      description: @description,
      package: package(),
      deps: deps(),
      source_url: @source_url,
      docs: [
        main: "readme",
        extras: [
          "README.md"
        ]
      ],
      dialyzer: [
        plt_add_deps: :transitive,
        flags: [
          :unmatched_returns,
          :race_conditions,
          :underspecs
          # :overspecs,
          # :specdiffs
        ]
      ]
    ]
  end

  defp package do
    [
      maintainers: ["erin"],
      licenses: ["MIT"],
      links: %{"Github" => @source_url}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0.0-rc.3", only: [:dev, :test], runtime: false}
    ]
  end
end
