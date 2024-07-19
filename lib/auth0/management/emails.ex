defmodule Auth0.Management.Emails do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Emails.Provider

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_provider "/api/v2/emails/provider"

  @doc """
  Get the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/get_provider

  """
  @spec get_provider(Provider.Get.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def get_provider(%{} = params, %Config{} = config) do
    Provider.Get.execute(@endpoint_provider, params, config)
  end

  @doc """
  Update the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/patch_provider

  """
  @spec update_provider(Provider.Patch.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def update_provider(%{} = params, %Config{} = config) do
    Provider.Patch.execute(@endpoint_provider, params, config)
  end

  @doc """
  Configure the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/post_provider

  """
  @spec configure_provider(Provider.Configure.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def configure_provider(%{} = params, %Config{} = config) do
    Provider.Configure.execute(@endpoint_provider, params, config)
  end
end
