defmodule Auth0.Entity.GuardianEnrollment do
  @moduledoc """
  Documentation for entity of GuardianEnrollment.

  """

  alias Auth0.Common.Util

  defstruct id: nil,
            status: nil,
            name: nil,
            identifier: nil,
            phone_number: nil,
            enrolled_at: nil,
            last_auth: nil

  @type t :: %__MODULE__{
          id: String.t(),
          status: String.t(),
          name: String.t(),
          identifier: String.t(),
          phone_number: String.t(),
          enrolled_at: String.t(),
          last_auth: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
