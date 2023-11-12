defmodule Auth0.Entity.GuardianPhoneTemplate do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct enrollment_message: nil,
            verification_message: nil

  @type t :: %__MODULE__{
          enrollment_message: String.t(),
          verification_message: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
