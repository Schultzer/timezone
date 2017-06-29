defmodule Timezone.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [app: :timezone,
     version: @version,
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     # Hex
     description: description(),
     package: package(),

     #Docs
     name: "Timezone",
     docs: [source_ref: "v#{@version}",
       main: "Timezone",
       canonical: "http://hexdocs.pm/timezone",
       source_url: "https://github.com/schultzer/timezone",
       description: "Timezone client Google Maps Time Zone API"]]

  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:httpoison, "~> 0.11"},
     {:poison, "~> 3.1"},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp description do
  """
  Timezone client Google Maps Time Zone API
  """
  end

  defp package do
    [name: :timezone,
     maintainers: ["Benjamin Schultzer"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/schultzer/timezone",
              "Docs" => "https://hexdocs.pm/timezone"},
     files: ~w(lib) ++
            ~w(mix.exs README.md LICENSE mix.exs)]
  end
end
