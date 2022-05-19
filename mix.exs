defmodule Erleans.MixProject do
  use Mix.Project

  def project do
    [
      app: :erleans,
      version: get_version("VERSION"),
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {:erleans_app, []},
      env: [deactivate_after: 2_700_000, refresh_interval: 5000, num_partitions: 128]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:lasp, github: "Inkwell-Data/lasp", branch: "master", override: true},
      {:lasp_pg, github: "Inkwell-Data/lasp_pg", branch: "master", override: true},
      {:partisan, github: "Inkwell-Data/partisan", branch: "master", override: true},
      {:gproc, "~> 0.9.0"},
      {:sbroker, github: "miniclip/sbroker", branch: "master", override: true},
      {:opentelemetry_api,
       github: "open-telemetry/opentelemetry-erlang",
       sparse: "apps/opentelemetry_api",
       override: true},
      {:types, github: "Inkwell-Data/types", branch: "master", override: true},
      {:erlware_commons, "~> 1.6.0"},
      {:uuid, "~> 1.8", hex: :uuid_erl, override: true},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp get_version(file) do
    {:ok, version} = File.read(file)
    String.trim(version)
  end

  defp package() do
    [
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
        license* CHANGELOG* changelog* src VERSION rebar.config rebar.lock),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/erleans/erleans"}
    ]
  end
end
