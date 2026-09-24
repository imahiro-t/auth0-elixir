defmodule Auth0Api.MixProject do
  use Mix.Project

  @description "Management API for Auth0"
  @source_url "https://github.com/imahiro-t/auth0-elixir"

  def project do
    [
      app: :auth0_api,
      version: "2.4.0",
      elixir: "~> 1.17",
      name: "Auth0Api",
      description: @description,
      package: package(),
      deps: deps(),
      source_url: @source_url,
      docs: [
        main: "readme",
        extras: [
          "README.md",
          "CHANGELOG.md"
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
    [
      mod: {Auth0.Application, []},
      extra_applications: [:logger, :crypto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 3.0"},
      # Direct lower bound on hackney so that consumers cannot resolve a
      # vulnerable version: hackney < 4.0.1 is affected by GHSA-gp9c-pm5m-5cxr,
      # GHSA-j9wq-vxxc-94wf, GHSA-pj7v-xfvx-wmjq, GHSA-mp55-p8c9-rfw2 and more,
      # and hackney 4.0.1 / 4.0.2 pin quic 1.4.3, which is affected by
      # GHSA-2r8v-p65x-3663 (critical, broken TLS verification, fixed in quic
      # 1.4.4). httpoison 3.0 alone (hackney ~> 4.0) would allow all of those.
      {:hackney, "~> 4.1"},
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:bypass, "~> 2.1", only: :test}
    ]
  end
end
