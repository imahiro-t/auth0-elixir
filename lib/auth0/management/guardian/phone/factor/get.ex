defmodule Auth0.Management.Guardian.Phone.Factor.Get do
  @moduledoc """
  Documentation for Auth0 Management Retrieve the Enabled Phone Factors.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_message_types
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianPhoneFactor

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: GuardianPhoneFactor.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve the Enabled Phone Factors.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_message_types

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, GuardianPhoneFactor.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
