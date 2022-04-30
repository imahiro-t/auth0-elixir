defmodule Auth0.Management.Roles.Create do
  @moduledoc """
  Documentation for Auth0 Management Create a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_roles
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Role

  defmodule Params do
    defstruct name: nil,
              description: nil

    @type t :: %__MODULE__{
            name: String.t(),
            description: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Role.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create a role.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Roles/post_roles

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 200, body} -> {:ok, Role.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
