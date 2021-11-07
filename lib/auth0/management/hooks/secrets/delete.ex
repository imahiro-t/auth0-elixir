defmodule Auth0.Management.Hooks.Secrets.Delete do
  @moduledoc """
  Documentation for Auth0 Management Delete hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/delete_secrets
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http

  defmodule Params do
    defstruct value: nil

    @type t :: %__MODULE__{
            value: list
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Delete hook secrets.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/delete_secrets

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    body = params.value

    endpoint
    |> String.replace("{id}", id)
    |> Http.delete(body, config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
