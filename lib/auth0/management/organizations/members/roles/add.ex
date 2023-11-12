defmodule Auth0.Management.Organizations.Members.Roles.Add do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defstruct roles: nil

    @type t :: %__MODULE__{
            roles: list(String.t())
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type user_id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Assign one or more roles to a given user that will be applied in the context of the provided organization.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Organizations/post_organization_member_roles

  """
  @spec execute(endpoint, id, user_id, params, config) :: response
  def execute(endpoint, id, user_id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, user_id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, user_id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{id}", id)
    |> String.replace("{user_id}", user_id)
    |> Http.post(body, config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
