defmodule Auth0.Management.Users.Multifactor.Delete do
  @moduledoc """
  Documentation for Auth0 Management Delete a User's Multi-factor Provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_multifactor_by_provider
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    defstruct provider: nil

    @type t :: %__MODULE__{
            provider: String.t()
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Delete a User's Multi-factor Provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/delete_multifactor_by_provider

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> String.replace("{provider}", params.provider)
    |> Http.delete(config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
