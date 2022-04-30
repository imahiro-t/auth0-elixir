defmodule Auth0.Management.Organizations.Members.Roles.List do
  @moduledoc """
  Documentation for Auth0 Management Get the roles assigned to an organization member

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organization_member_roles
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Roles

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
  @type user_id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Roles.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get the roles assigned to an organization member

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/get_organization_member_roles

  """
  @spec execute(endpoint, id, user_id, params, config) :: response
  def execute(endpoint, id, user_id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, user_id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, user_id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(
      endpoint
      |> String.replace("{id}", id)
      |> String.replace("{user_id}", user_id)
    )
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Roles.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
