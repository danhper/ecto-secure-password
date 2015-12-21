defmodule SecurePassword.Mixfile do
  use Mix.Project

  def project do
    [app: :secure_password,
     version: "0.3.0",
     elixir: "~> 1.1",
     package: package,
     description: description,
     source_url: "http://github.com/tuvistavie/ecto-secure-password",
     homepage_url: "http://github.com/tuvistavie/ecto-secure-password",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:comeonin]]
  end

  defp description do
    "A port of Rails has_secure_password for Ecto models"
  end

  defp deps do
    [
      {:ecto, "~> 1.0"},
      {:comeonin, "~> 2.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end

  defp package do
  [
    files: ["lib", "mix.exs", "README.md", "LICENSE"],
    maintainers: ["Daniel Perez"],
    licenses: ["MIT"],
    links: %{"GitHub" => "https://github.com/tuvistavie/ecto-secure-password"}
  ]
 end
end
