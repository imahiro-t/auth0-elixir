defmodule Auth0.Management.EmailTemplates.Create do
  @moduledoc """
  Documentation for Auth0 Management Create an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/post_email_templates
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
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: EmailTemplate.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create an email template.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Email_Templates/post_email_templates

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 200, body} -> {:ok, EmailTemplate.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
