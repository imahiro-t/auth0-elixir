defmodule Auth0.Management.Guardian.Phone.Configuration.Put do
  @moduledoc """
  Documentation for Auth0 Management Update phone configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_selected_provider
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianPhoneConfiguration

  defmodule Params do
    defstruct provider: nil

    @type t :: %__MODULE__{
            provider: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: GuardianPhoneConfiguration.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update phone configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_selected_provider

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, GuardianPhoneConfiguration.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
