defmodule Auth0.Management.Tenants.Settings.Get do
  @moduledoc """
  Documentation for Auth0 Management Get tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/tenant_settings_route
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.TenantSetting

  defmodule Params do
    defstruct fields: nil,
              include_fields: nil

    @type t :: %__MODULE__{
            fields: String.t(),
            include_fields: boolean
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: TenantSetting.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get tenant settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tenants/tenant_settings_route

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, TenantSetting.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
