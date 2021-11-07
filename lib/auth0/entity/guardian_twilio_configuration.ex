defmodule Auth0.Entity.GuardianTwilioConfiguration do
  @moduledoc """
  Documentation for entity of GuardianTwilioConfiguration.

  """

  alias Auth0.Common.Util

  defstruct from: nil,
            messaging_service_sid: nil,
            auth_token: nil,
            sid: nil

  @type t :: %__MODULE__{
          from: String.t(),
          messaging_service_sid: String.t(),
          auth_token: String.t(),
          sid: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
