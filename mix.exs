defmodule Auth0Api.MixProject do
  use Mix.Project

  @description "Elixir client for the Auth0 Management API v2 and the Authentication API (client credentials)"
  @source_url "https://github.com/imahiro-t/auth0-elixir"

  def project do
    [
      app: :auth0_api,
      version: "2.5.0",
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
          "CHANGELOG.md",
          "docs/management_api_diff.md"
        ]
      ],
      dialyzer: [
        plt_add_deps: :app_tree,
        # Keep PLTs under _build (already git-ignored and never part of the Hex
        # package). priv/ would be picked up by `mix hex.build` because the
        # package has no explicit `files` list.
        plt_local_path: "_build/plts",
        plt_core_path: "_build/plts",
        flags: [
          :unmatched_returns,
          :underspecs
          # :overspecs,
          # :specdiffs
        ]
      ]
    ]
  end

  defp package do
    [
      maintainers: ["Takashi Imahiro"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "Changelog" => "https://hexdocs.pm/auth0_api/changelog.html"
      }
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
      {:bypass, "~> 2.1", only: :test},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end
end
