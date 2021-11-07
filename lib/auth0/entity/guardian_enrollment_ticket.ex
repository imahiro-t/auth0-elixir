defmodule Auth0.Entity.GuardianEnrollmentTicket do
  @moduledoc """
  Documentation for entity of GuardianEnrollmentTicket.

  """

  alias Auth0.Common.Util

  defstruct user_id: nil,
            email: nil,
            send_mail: nil

  @type t :: %__MODULE__{
          user_id: String.t(),
          email: String.t(),
          send_mail: boolean
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
