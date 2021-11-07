defmodule Auth0.Management.DeviceCredentials.List do
  @moduledoc """
  Documentation for Auth0 Management Retrieve device credentials.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/get_device_credentials
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.DeviceCredentials

  defmodule Params do
    defstruct page: nil,
              per_page: nil,
              include_totals: nil,
              fields: nil,
              include_fields: nil,
              user_id: nil,
              client_id: nil,
              type: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer,
            include_totals: boolean,
            fields: String.t(),
            include_fields: boolean,
            user_id: String.t(),
            client_id: String.t(),
            type: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: DeviceCredentials.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve device credentials.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/get_device_credentials

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, DeviceCredentials.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
