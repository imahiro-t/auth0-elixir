defmodule Auth0.Authentication.Token.ClientCredentials do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Authentication.Http
  alias Auth0.Entity.Token

  defmodule Params do
    @moduledoc false
    defstruct audience: nil,
              client_id: nil,
              client_secret: nil

    @type t :: %__MODULE__{
            audience: String.t(),
            client_id: String.t(),
            client_secret: String.t()
          }
  end

  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Token.t()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/oauth/token"
  @headers %{"Content-Type" => "application/x-www-form-urlencoded"}

  @doc """
  Client Credentials Flow.

  ## see
  https://auth0.com/docs/api/authentication#client-credentials-flow

  """
  @spec execute(params, config) :: response
  def execute(%Params{} = params, %Config{} = config) do
    body =
      params
      |> Util.to_map()
      |> Map.put(:grant_type, "client_credentials")
      |> Util.convert_to_form_body()

    Http.request_with_retry(
      fn url -> HTTPoison.post(url, body, @headers) end,
      @endpoint,
      config
    )
    |> case do
      {:ok, 200, body} -> {:ok, Token.from(body |> Jason.decode!())}
      error -> error
    end
  end
end
