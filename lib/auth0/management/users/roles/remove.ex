defmodule Auth0.Management.Users.Roles.Remove do
  @moduledoc """
  Documentation for Auth0 Management Removes roles from a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_roles
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    defstruct roles: []

    @type t :: %__MODULE__{
            roles: list(String.t())
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Removes roles from a user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_user_roles

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.delete(body, config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
