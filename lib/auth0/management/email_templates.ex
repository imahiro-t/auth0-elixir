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

  @endpoint "/api/v2/email-templates"
  @endpoint_by_name "/api/v2/email-templates/{templateName}"

  @doc """
  Get an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/get_email_templates_by_templateName

  """
  @spec get(template_name, config) ::
          {:ok, list() | map()} | error
  def get(template_name, %Config{} = config) do
    Get.execute(@endpoint_by_name, template_name, config)
  end

  @doc """
  Patch an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/patch_email_templates_by_templateName

  """
  @spec patch(template_name, Patch.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def patch(template_name, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_name, template_name, params, config)
  end

  @doc """
  Update an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/put_email_templates_by_templateName

  """
  @spec update(template_name, Update.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def update(template_name, %{} = params, %Config{} = config) do
    Update.execute(@endpoint_by_name, template_name, params, config)
  end

  @doc """
  Create an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/post_email_templates

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, list() | map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end
end
