defmodule Auth0.Management.Organizations.EnabledConnections.Patch do
  @moduledoc """
  Documentation for Auth0 Management Modify an Organizations Connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_enabled_connections_by_connectionId
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.EnabledConnection

  defmodule Params do
    defstruct assign_membership_on_login: nil

    @type t :: %__MODULE__{
            assign_membership_on_login: boolean
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type connection_id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: EnabledConnection.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Modify an Organizations Connection.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/patch_enabled_connections_by_connectionId

  """
  @spec execute(endpoint, id, connection_id, params, config) :: response
  def execute(endpoint, id, connection_id, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> String.replace("{connectionId}", connection_id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, EnabledConnection.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
