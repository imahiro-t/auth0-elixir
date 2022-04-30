defmodule Auth0.Management.EmailTemplates.Update do
  @moduledoc """
  Documentation for Auth0 Management Update an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/put_email_templates_by_templateName
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.EmailTemplate

  defmodule Params do
    defstruct template: nil,
              body: nil,
              from: nil,
              resultUrl: nil,
              subject: nil,
              syntax: nil,
              urlLifetimeInSeconds: nil,
              includeEmailInRedirect: nil,
              enabled: nil

    @type t :: %__MODULE__{
            template: String.t(),
            body: String.t(),
            from: String.t(),
            resultUrl: String.t(),
            subject: String.t(),
            syntax: String.t(),
            urlLifetimeInSeconds: integer,
            includeEmailInRedirect: boolean,
            enabled: boolean
          }
  end

  @type endpoint :: String.t()
  @type template_name :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: EmailTemplate.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/put_email_templates_by_templateName

  """
  @spec execute(endpoint, template_name, params, config) :: response
  def execute(endpoint, template_name, %Params{} = params, %Config{} = config) do
    execute(endpoint, template_name, params |> Util.to_map(), config)
  end

  def execute(endpoint, template_name, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{templateName}", template_name)
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, EmailTemplate.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
