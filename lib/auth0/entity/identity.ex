defmodule Auth0.Entity.Identity do
  @moduledoc false

  defmodule ProfileData do
    @moduledoc false

    alias Auth0.Common.Util

    defstruct email: nil,
              email_verified: nil,
              name: nil,
              username: nil,
              given_name: nil,
              phone_number: nil,
              phone_verified: nil,
              family_name: nil,
              picture: nil,
              locale: nil,
              nonce_supported: nil

    @type t :: %__MODULE__{
            email: String.t(),
            email_verified: boolean,
            name: String.t(),
            username: String.t(),
            given_name: String.t(),
            phone_number: String.t(),
            phone_verified: boolean,
            family_name: String.t(),
            picture: String.t(),
            locale: String.t(),
            nonce_supported: boolean
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      value |> Util.to_struct(__MODULE__)
    end
  end

  alias Auth0.Common.Util

  defstruct connection: nil,
            user_id: nil,
            provider: nil,
            isSocial: false,
            access_token: nil,
            profileData: nil

  @type t :: %__MODULE__{
          connection: String.t(),
          user_id: String.t(),
          provider: String.t(),
          isSocial: boolean,
          access_token: String.t(),
          profileData: ProfileData.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    identity = value |> Util.to_struct(__MODULE__)

    if identity.profileData |> is_map do
      %{identity | profileData: identity.profileData |> ProfileData.from()}
    else
      identity
    end
  end
end
