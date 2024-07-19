defmodule Auth0.Management.Emails.Provider.Configure do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defstruct name: nil,
              enabled: nil,
              default_from_address: nil,
              credentials: nil,
              settings: nil

    @type t :: %__MODULE__{
            name: String.t(),
            enabled: boolean,
            default_from_address: String.t(),
            credentials: map,
            settings: map
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Configure the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/post_provider

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
