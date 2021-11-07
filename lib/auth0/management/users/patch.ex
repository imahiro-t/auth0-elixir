defmodule Auth0.Management.Users.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/patch_users_by_id
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.User

  defmodule Params do
    defstruct blocked: nil,
              email_verified: nil,
              email: nil,
              phone_number: nil,
              phone_verified: nil,
              user_metadata: nil,
              app_metadata: nil,
              given_name: nil,
              family_name: nil,
              name: nil,
              nickname: nil,
              picture: nil,
              verify_email: nil,
              verify_phone_number: nil,
              password: nil,
              connection: nil,
              client_id: nil,
              username: nil

    @type t :: %__MODULE__{
            blocked: boolean,
            email_verified: boolean,
            email: String.t(),
            phone_number: String.t(),
            phone_verified: boolean,
            user_metadata: map,
            app_metadata: map,
            given_name: String.t(),
            family_name: String.t(),
            name: String.t(),
            nickname: String.t(),
            picture: String.t(),
            verify_email: boolean,
            verify_phone_number: boolean,
            password: String.t(),
            connection: String.t(),
            client_id: String.t(),
            username: String.t()
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: User.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/patch_users_by_id

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, User.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
