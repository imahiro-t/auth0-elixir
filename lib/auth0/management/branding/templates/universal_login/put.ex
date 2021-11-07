defmodule Auth0.Management.Branding.Templates.UniversalLogin.Put do
  @moduledoc """
  Documentation for Auth0 Management Set template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/put_universal_login
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    defstruct template: nil

    @type t :: %__MODULE__{
            template: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Set template for New Universal Login Experience.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Branding/put_universal_login

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    Http.put(endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body, body}
      {:ok, 204, body} -> {:ok, body, body}
      error -> error
    end
  end
end
