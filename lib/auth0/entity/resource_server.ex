defmodule Auth0.Entity.ResourceServer do
  @moduledoc """
  Documentation for entity of ResourceServer.

  """

  alias Auth0.Common.Util

  defstruct id: nil,
            name: nil,
            is_system: nil,
            identifier: nil,
            scopes: nil,
            signing_alg: nil,
            signing_secret: nil,
            allow_offline_access: nil,
            skip_consent_for_verifiable_first_party_clients: nil,
            token_lifetime: nil,
            token_lifetime_for_web: nil,
            enforce_policies: nil,
            token_dialect: nil,
            client: nil

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          is_system: boolean,
          identifier: String.t(),
          scopes: list(String.t()),
          signing_alg: String.t(),
          signing_secret: String.t(),
          allow_offline_access: boolean,
          skip_consent_for_verifiable_first_party_clients: boolean,
          token_lifetime: integer,
          token_lifetime_for_web: integer,
          enforce_policies: boolean,
          token_dialect: String.t(),
          client: map
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
