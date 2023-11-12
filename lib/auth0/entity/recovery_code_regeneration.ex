defmodule Auth0.Entity.RecoveryCodeRegeneration do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct recovery_code: nil

  @type t :: %__MODULE__{
          recovery_code: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
