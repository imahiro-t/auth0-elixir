defmodule Auth0.Management.Users.Organizations.List do
  @moduledoc """
  Documentation for Auth0 Management List user's organizations.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_user_organizations
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Organizations

  defmodule Params do
    defstruct page: nil,
              per_page: nil,
              include_totals: nil

    @type t :: %__MODULE__{
            page: integer,
            per_page: integer,
            include_totals: boolean
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Organizations.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  List user's organizationss.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users/get_user_organizations

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(endpoint |> String.replace("{id}", id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Organizations.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
