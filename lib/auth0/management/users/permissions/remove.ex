defmodule Auth0.Management.Users.Permissions.Remove do
  @moduledoc """
  Documentation for Auth0 Management Remove Permissions from a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_permissions
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    defmodule Permission do
      defstruct resource_server_identifier: nil, permission_name: nil

      @type t :: %__MODULE__{
              resource_server_identifier: String.t(),
              permission_name: String.t()
            }
    end

    defstruct permissions: []

    @type t :: %__MODULE__{
            permissions: Permission.t()
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
  Remove Permissions from a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_permissions

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    body =
      params
      |> Util.to_map()
      |> Util.remove_nil()
      |> case do
        map = %{permissions: permissions} when permissions |> is_list ->
          %{
            map
            | permissions: permissions |> Enum.map(&(&1 |> Util.to_map() |> Util.remove_nil()))
          }

        map ->
          map
      end

    endpoint
    |> String.replace("{id}", id)
    |> Http.delete(body, config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
