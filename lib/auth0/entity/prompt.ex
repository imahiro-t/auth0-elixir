defmodule Auth0.Entity.Prompt do
  @moduledoc false

  alias Auth0.Common.Util

  defstruct universal_login_experience: nil,
            identifier_first: nil,
            webauthn_platform_first_factor: nil

  @type t :: %__MODULE__{
          universal_login_experience: String.t(),
          identifier_first: boolean,
          webauthn_platform_first_factor: boolean
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
