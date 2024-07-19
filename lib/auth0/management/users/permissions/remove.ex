defmodule Auth0.Management.Users.Permissions.Remove do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defmodule Permission do
      @moduledoc false
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
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Remove Permissions from a User.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_permissions

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    body =
      params
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
      {:ok, 204, _body} -> {:ok, ""}
      error -> error
    end
  end
end
