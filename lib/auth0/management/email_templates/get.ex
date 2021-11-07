defmodule Auth0.Management.EmailTemplates.Get do
  @moduledoc """
  Documentation for Auth0 Management Get an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/get_email_templates_by_templateName
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.EmailTemplate

  @type endpoint :: String.t()
  @type template_name :: String.t()
  @type config :: Config.t()
  @type entity :: EmailTemplate.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/get_email_templates_by_templateName

  """
  @spec execute(endpoint, template_name, config) :: response
  def execute(endpoint, template_name, %Config{} = config) do
    endpoint
    |> String.replace("{templateName}", template_name)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, EmailTemplate.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
