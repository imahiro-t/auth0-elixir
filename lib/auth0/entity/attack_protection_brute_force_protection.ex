defmodule Auth0.Entity.AttackProtectionBruteForceProtection do
  @moduledoc """
  Documentation for entity of AttackProtectionBruteForceProtection.

  """

  alias Auth0.Common.Util

  defstruct enabled: nil,
            shields: nil,
            allowlist: nil,
            mode: nil,
            max_attempts: nil

  @type t :: %__MODULE__{
          enabled: boolean,
          shields: list(String.t()),
          allowlist: list(String.t()),
          mode: String.t(),
          max_attempts: integer
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
