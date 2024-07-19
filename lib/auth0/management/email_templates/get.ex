defmodule Auth0.Management.EmailTemplates.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  @type endpoint :: String.t()
  @type template_name :: String.t()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

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
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
