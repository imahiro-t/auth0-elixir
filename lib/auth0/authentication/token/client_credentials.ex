defmodule Auth0.Authentication.Token.ClientCredentials do
  @moduledoc """
  Documentation for Auth0 Authentication Client Credentials Flow.

  ## see
  https://auth0.com/docs/api/authentication#client-credentials-flow
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Authentication.Http
  alias Auth0.Entity.Token

  defmodule Params do
    defstruct audience: nil,
              client_id: nil,
              client_secret: nil

    @type t :: %__MODULE__{
            audience: String.t(),
            client_id: String.t(),
            client_secret: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Token.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @headers %{"Content-Type" => "application/x-www-form-urlencoded"}

  @doc """
  Client Credentials Flow.

  ## see
  https://auth0.com/docs/api/authentication#client-credentials-flow

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body =
      params
      |> Util.to_map()
      |> Map.put(:grant_type, "client_credentials")
      |> Util.convert_to_form_body()

    Http.request_with_retry(
      fn url -> HTTPoison.post(url, body, @headers) end,
      endpoint,
      config
    )
    |> case do
      {:ok, 200, body} -> {:ok, Token.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
