defmodule Auth0.Management.EmailTemplates do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.EmailTemplates.Get
  alias Auth0.Management.EmailTemplates.Patch
  alias Auth0.Management.EmailTemplates.Update
  alias Auth0.Management.EmailTemplates.Create

  @type template_name :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Create an email template.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/post-email-templates

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve an email template by pre-defined name. These names are verify_email, verify_email_by_code, reset_email, welcome_email, blocked_account, stolen_credentials, enrollment_email, mfa_oob_code, and user_invitation. The names change_password, and password_reset are also supported for legacy scenarios.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/get-email-templates-by-template-name

  """
  @spec get(template_name, config) ::
          {:ok, map()} | error
  def get(template_name, %Config{} = config) do
    Get.execute(template_name, config)
  end

  @doc """
  Modify an email template.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/patch-email-templates-by-template-name

  """
  @spec patch(template_name, map(), config) ::
          {:ok, map()} | error
  def patch(template_name, %{} = params, %Config{} = config) do
    Patch.execute(template_name, params, config)
  end

  @doc """
  Update an email template.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/put-email-templates-by-template-name

  """
  @spec update(template_name, map(), config) ::
          {:ok, map()} | error
  def update(template_name, %{} = params, %Config{} = config) do
    Update.execute(template_name, params, config)
  end
end
