defmodule Auth0.Management.EmailTemplates.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type template_name :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/email-templates/{templateName}"

  @doc """
  Modify an email template.

  ## see
  https://auth0.com/docs/api/management/v2/email-templates/patch-email-templates-by-template-name

  """
  def execute(template_name, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> String.replace("{templateName}", template_name)
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
