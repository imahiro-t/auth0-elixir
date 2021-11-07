defmodule Auth0.Management.Emails do
  @moduledoc """
  Documentation for Auth0 Management API of Emails.

  ## endpoint
  - /api/v2/emails/provider
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Emails.Provider

  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_provider "/api/v2/emails/provider"

  @doc """
  Get the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/get_provider

  """
  @spec get_provider(Provider.Get.Params.t(), config) ::
          {:ok, Entity.EmailProvider.t(), response_body} | error
  def get_provider(%Provider.Get.Params{} = params, %Config{} = config) do
    Provider.Get.execute(@endpoint_provider, params, config)
  end

  @doc """
  Delete the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/delete_provider

  """
  @spec delete_provider(config) :: {:ok, String.t(), response_body} | error
  def delete_provider(%Config{} = config) do
    Provider.Delete.execute(@endpoint_provider, config)
  end

  @doc """
  Update the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/patch_provider

  """
  @spec update_provider(Provider.Patch.Params.t(), config) ::
          {:ok, Entity.EmailProvider.t(), response_body} | error
  def update_provider(%Provider.Patch.Params{} = params, %Config{} = config) do
    Provider.Patch.execute(@endpoint_provider, params, config)
  end

  @doc """
  Configure the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/post_provider

  """
  @spec configure_provider(Provider.Configure.Params.t(), config) ::
          {:ok, Entity.EmailProvider.t(), response_body} | error
  def configure_provider(%Provider.Configure.Params{} = params, %Config{} = config) do
    Provider.Configure.execute(@endpoint_provider, params, config)
  end
end
