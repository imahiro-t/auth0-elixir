defmodule Auth0.Management.NetworkAcls.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Common.Util

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map() | String.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/network-acls"

  @doc """
  Create a network ACL.

  ## see
  https://auth0.com/docs/api/management/v2/network-acls/post-network-acls
  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    @endpoint
    |> Http.post(params, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Util.decode_json_or_string!()}
      error -> error
    end
  end
end
