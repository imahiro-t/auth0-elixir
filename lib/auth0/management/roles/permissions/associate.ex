defmodule Auth0.Management.Roles.Permissions.Associate do
  @moduledoc """
  Documentation for Auth0 Management Associate permissions with a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_role_permission_assignment
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    defmodule Permission do
      defstruct resource_server_identifier: nil,
                permission_name: nil

      @type t :: %__MODULE__{
              resource_server_identifier: String.t(),
              permission_name: String.t()
            }
    end

    defstruct permissions: nil

    @type t :: %__MODULE__{
            permissions: list(Permission.t())
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
  Associate permissions with a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_role_permission_assignment

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, "", body}
      error -> error
    end
  end
end
