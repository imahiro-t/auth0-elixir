defmodule Auth0.Entity.GuardianPhoneConfiguration do
  @moduledoc """
  Documentation for entity of GuardianPhoneConfiguration.

  """

  alias Auth0.Common.Util

  defstruct provider: nil

  @type t :: %__MODULE__{
          provider: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
