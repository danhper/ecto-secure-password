defmodule SecurePassword.Mixfile do
  use Mix.Project

  def project do
    [app: :secure_password,
     version: "0.1.0",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:comeonin]]
  end

  defp deps do
    [
      {:ecto, "~> 1.0"},
      {:comeonin, "~> 1.6"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev}
    ]
  end
end
