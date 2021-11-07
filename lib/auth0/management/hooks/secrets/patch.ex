defmodule Auth0.Management.Hooks.Secrets.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  defmodule Params do
    defstruct value: nil

    @type t :: %__MODULE__{
            value: map
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: map
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/patch_hooks_by_id

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    body = params.value

    endpoint
    |> String.replace("{id}", id)
    |> Http.patch(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!(), body}
      error -> error
    end
  end
end
