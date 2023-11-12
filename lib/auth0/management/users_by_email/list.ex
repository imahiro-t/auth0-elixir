defmodule Auth0.Management.UsersByEmail.List do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Users

  defmodule Params do
    @moduledoc false
    defstruct fields: nil,
              include_fields: nil,
              email: nil

    @type t :: %__MODULE__{
            fields: String.t(),
            include_fields: boolean,
            email: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Users.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Search Users by Email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Users_By_Email/get_users_by_email

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(endpoint)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Users.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
