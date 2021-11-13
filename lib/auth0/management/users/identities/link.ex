defmodule Auth0.Management.Users.Identities.Link do
  @moduledoc """
  Documentation for Auth0 Management Link a User Account.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_identities
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Identities

  defmodule Params do
    defstruct provider: nil,
              connection_id: nil,
              user_id: nil

    @type t :: %__MODULE__{
            provider: String.t(),
            connection_id: String.t(),
            user_id: String.t()
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Identities.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Link a User Account.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/post_identities

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, Identities.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
