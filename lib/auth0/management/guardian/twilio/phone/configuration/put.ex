defmodule Auth0.Management.Guardian.Twilio.Phone.Configuration.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defstruct from: nil,
              messaging_service_sid: nil,
              auth_token: nil,
              sid: nil

    @type t :: %__MODULE__{
            from: String.t(),
            messaging_service_sid: String.t(),
            auth_token: String.t(),
            sid: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Update Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
