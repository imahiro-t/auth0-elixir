defmodule Auth0.Management.Guardian.Phone.Template.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianPhoneTemplate

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: GuardianPhoneTemplate.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve Enrollment and Verification Phone Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_templates

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} ->
        {:ok, GuardianPhoneTemplate.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
