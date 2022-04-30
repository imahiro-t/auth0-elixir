defmodule Auth0.Management.Guardian.Factors.Put do
  @moduledoc """
  Documentation for Auth0 Management Update a Multi-factor Authentication Factor.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_factors_by_name
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianFactor

  defmodule Params do
    defstruct enabled: nil

    @type t :: %__MODULE__{
            enabled: boolean
          }
  end

  @type endpoint :: String.t()
  @type name :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: GuardianFactor.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update a Multi-factor Authentication Factor.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_factors_by_name

  """
  @spec execute(endpoint, name, params, config) :: response
  def execute(endpoint, name, %Params{} = params, %Config{} = config) do
    execute(endpoint, name, params |> Util.to_map(), config)
  end

  def execute(endpoint, name, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{name}", name)
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, GuardianFactor.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
