defmodule Auth0.Management.ClientGrants.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ClientGrant

  defmodule Params do
    @moduledoc false
    defstruct client_id: nil,
              audience: nil,
              scope: nil

    @type t :: %__MODULE__{
            client_id: String.t(),
            audience: String.t(),
            scope: list(String.t())
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: ClientGrant.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create client grant.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Client_Grants/post_client_grants

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, ClientGrant.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
