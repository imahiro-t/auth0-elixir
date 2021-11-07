defmodule Auth0.Management.Organizations.EnabledConnections.Create do
  @moduledoc """
  Documentation for Auth0 Management Add connections to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_enabled_connections
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.EnabledConnection

  defmodule Params do
    defstruct connection_id: nil,
              assign_membership_on_login: nil

    @type t :: %__MODULE__{
            connection_id: String.t(),
            assign_membership_on_login: boolean
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: EnabledConnection.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Add connections to an organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_enabled_connections

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, EnabledConnection.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
