defmodule Auth0.Management.Users.Create do
  @moduledoc """
  Documentation for Auth0 Management Create a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_users
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.User

  defmodule Params do
    defstruct email: nil,
              phone_number: nil,
              user_metadata: nil,
              blocked: nil,
              email_verified: nil,
              phone_verified: nil,
              app_metadata: nil,
              given_name: nil,
              family_name: nil,
              name: nil,
              nickname: nil,
              picture: nil,
              user_id: nil,
              connection: nil,
              password: nil,
              verify_email: nil,
              username: nil

    @type t :: %__MODULE__{
            email: String.t(),
            phone_number: String.t(),
            user_metadata: map,
            blocked: boolean,
            email_verified: boolean,
            phone_verified: boolean,
            app_metadata: map,
            given_name: String.t(),
            family_name: String.t(),
            name: String.t(),
            nickname: String.t(),
            picture: String.t(),
            user_id: String.t(),
            connection: String.t(),
            password: String.t(),
            verify_email: boolean,
            username: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: User.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_users

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, User.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
