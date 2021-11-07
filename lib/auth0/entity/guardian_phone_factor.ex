defmodule Auth0.Entity.GuardianPhoneFactor do
  @moduledoc """
  Documentation for entity of GuardianPhoneFactor.

  """

  alias Auth0.Common.Util

  defstruct message_types: nil

  @type t :: %__MODULE__{
          message_types: list(String.t())
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
