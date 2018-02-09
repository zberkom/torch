defmodule Mix.Tasks.Torch.Gen.Context do
  @moduledoc """
  Light wrapper module around phx.gen.context. Installs and uninstalls context
  templates around running the phoenix generator.

  ## Parameters

  Takes all the same params as the regualar phx generators.

  # TODO

  ## Example

      mix torch.gen.context Accounts User users --no-schema
  """

  def run([project_name, format, context | args]) do
    Mix.Task.run("torch.install", [project_name, format])
    Mix.Task.run("phx.gen.context", [context | args])
    Mix.Task.run("torch.uninstall", [project_name, format])

    Mix.shell().info("""
    #{hr()}
                                    #{IO.ANSI.yellow()}TORCH GENERATED #{context}! #{
      IO.ANSI.reset()
    }
    #{hr()}
    """)
  end

  defp hr do
    for _ <- 1..80, into: "", do: "\u{1F525}"
  end
end