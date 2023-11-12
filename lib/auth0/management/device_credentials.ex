defmodule Auth0.Management.DeviceCredentials do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.DeviceCredentials.List
  alias Auth0.Management.DeviceCredentials.Create
  alias Auth0.Management.DeviceCredentials.Delete

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/device-credentials"
  @endpoint_by_id "/api/v2/device-credentials/{id}"

  @doc """
  Retrieve device credentials.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/get_device_credentials

  """
  @spec list(List.Params.t() | map, config) ::
          {:ok, Entity.DeviceCredentials.t(), response_body} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create a device public key credential.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/post_device_credentials

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, Entity.DeviceCredential.t(), response_body} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Delete a device credential.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Device_Credentials/delete_device_credentials_by_id

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end
end
