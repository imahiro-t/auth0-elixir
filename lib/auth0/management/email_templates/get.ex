defmodule Auth0.Management.EmailTemplates.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type template_name :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/email-templates/{templateName}"

  @doc """
  Retrieve an email template by pre-defined name. These names are verify_email, verify_email_by_code, reset_email, welcome_email, blocked_account, stolen_credentials, enrollment_email, mfa_oob_code, and user_invitation. The names change_password, and password_reset are also supported for legacy scenarios.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/get-email-templates-by-template-name

  """
  @spec execute(template_name, config) :: response
  def execute(template_name, %Config{} = config) do
    @endpoint
    |> String.replace("{templateName}", template_name)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
