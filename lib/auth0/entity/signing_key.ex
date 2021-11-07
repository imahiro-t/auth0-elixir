defmodule Auth0.Entity.SigningKey do
  @moduledoc """
  Documentation for entity of SigningKey.

  """

  alias Auth0.Common.Util

  defstruct kid: nil,
            cert: nil,
            pkcs7: nil,
            current: nil,
            next: nil,
            previous: nil,
            current_since: nil,
            current_until: nil,
            fingerprint: nil,
            thumbprint: nil,
            revoked: nil,
            revoked_at: nil

  @type t :: %__MODULE__{
          kid: String.t(),
          cert: String.t(),
          pkcs7: String.t(),
          current: boolean,
          next: boolean,
          previous: boolean,
          current_since: String.t(),
          current_until: String.t(),
          fingerprint: String.t(),
          thumbprint: String.t(),
          revoked: boolean,
          revoked_at: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
