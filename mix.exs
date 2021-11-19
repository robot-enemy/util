defmodule Util.MixProject do
  @moduledoc false
  use Mix.Project

  def project do
    [
      app: :util,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:crypto, :logger]
    ]
  end

  # NOTE: Util should be zero deps, if it needs a dependency, consider creating
  #       a separate library.
  defp deps do
    [
      {:faker, "~> 0.16", only: :test},
    ]
  end

end
