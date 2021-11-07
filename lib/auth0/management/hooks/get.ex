defmodule Auth0.Management.Hooks.Get do
  @moduledoc """
  Documentation for Auth0 Management Get a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_hooks
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Hook

  defmodule Params do
    defstruct fields: nil

    @type t :: %__MODULE__{
            fields: String.t()
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Hook.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get a hook.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Hooks/post_hooks

  """
  @spec execute(endpoint, id, params, config) :: response
  def execute(endpoint, id, %Params{} = params, %Config{} = config) do
    params
    |> Util.to_map()
    |> Util.convert_to_query()
    |> Util.append_query(endpoint |> String.replace("{id}", id))
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, Hook.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
