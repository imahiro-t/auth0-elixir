defmodule Auth0.Entity.User do
  @moduledoc false

  alias Auth0.Common.Util
  alias Auth0.Entity.Identity

  defstruct user_id: nil,
            email: nil,
            email_verified: nil,
            username: nil,
            phone_number: nil,
            phone_verified: nil,
            created_at: nil,
            updated_at: nil,
            identities: nil,
            app_metadata: nil,
            user_metadata: nil,
            picture: nil,
            name: nil,
            nickname: nil,
            multifactor: nil,
            last_ip: nil,
            last_login: nil,
            logins_count: nil,
            blocked: nil,
            given_name: nil,
            family_name: nil

  @type t :: %__MODULE__{
          user_id: String.t(),
          email: String.t(),
          email_verified: boolean,
          username: String.t(),
          phone_number: String.t(),
          phone_verified: boolean,
          created_at: String.t(),
          updated_at: String.t(),
          identities: list(Identity.t()),
          app_metadata: map,
          user_metadata: map,
          picture: String.t(),
          name: String.t(),
          nickname: String.t(),
          multifactor: list(String.t()),
          last_ip: String.t(),
          last_login: String.t(),
          logins_count: integer,
          blocked: boolean,
          given_name: String.t(),
          family_name: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    user = value |> Util.to_struct(__MODULE__)

    if user.identities |> is_list do
      %{user | identities: user.identities |> Enum.map(&Identity.from/1)}
    else
      user
    end
  end
end
