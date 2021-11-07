defmodule Auth0.Entity.GuardianFactor do
  @moduledoc """
  Documentation for entity of GuardianFactor.

  """

  alias Auth0.Common.Util

  defstruct enabled: nil,
            trial_expired: nil,
            name: nil

  @type t :: %__MODULE__{
          enabled: boolean,
          trial_expired: boolean,
          name: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
