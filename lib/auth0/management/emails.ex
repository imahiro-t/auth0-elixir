defmodule Auth0.Management.Emails do
  alias Auth0.Config
  alias Auth0.Management.Emails.Provider

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details of the email provider configuration in your tenant. A list of fields to include or exclude may also be specified.

  ## see
  https://auth0.com/docs/api/management/v2/emails/get-provider

  """
  @spec get_provider(map(), config) ::
          {:ok, map()} | error
  def get_provider(%{} = params, %Config{} = config) do
    Provider.Get.execute(params, config)
  end

  @doc """
  Update an email provider. The credentials object requires different properties depending on the email provider (which is specified using the name property):

  ## see
  https://auth0.com/docs/api/management/v2/emails/patch-provider

  """
  @spec update_provider(map(), config) ::
          {:ok, map()} | error
  def update_provider(%{} = params, %Config{} = config) do
    Provider.Patch.execute(params, config)
  end

  @doc """
  Create an email provider. The credentials object requires different properties depending on the email provider (which is specified using the name property):

  ## see
  https://auth0.com/docs/api/management/v2/emails/post-provider

  """
  @spec configure_provider(map(), config) ::
          {:ok, map()} | error
  def configure_provider(%{} = params, %Config{} = config) do
    Provider.Configure.execute(params, config)
  end
end
