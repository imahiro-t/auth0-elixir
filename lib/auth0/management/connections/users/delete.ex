defmodule Auth0.Management.Connections.Users.Delete do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defstruct email: nil

    @type t :: %__MODULE__{
            email: String.t()
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: String.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Delete a connection user.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Connections/delete_users_by_email

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, id, %{} = params, %Config{} = config) do
    params
    |> Util.convert_to_query()
    |> Util.append_query(endpoint |> String.replace("{id}", id))
    |> Http.delete(config)
    |> case do
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
