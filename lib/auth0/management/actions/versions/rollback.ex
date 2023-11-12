defmodule Auth0.Management.Actions.Versions.Rollback do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.ActionVersion

  defmodule Params do
    @moduledoc false
    defstruct update_draft: nil

    @type t :: %__MODULE__{
            update_draft: boolean
          }
  end

  @type endpoint :: String.t()
  @type action_id :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: ActionVersion.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Roll back to a previous action version.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Actions/post_deploy_draft_version

  """
  @spec execute(endpoint, action_id, id, params, config) :: response
  def execute(endpoint, action_id, id, %Params{} = params, %Config{} = config) do
    execute(endpoint, action_id, id, params |> Util.to_map(), config)
  end

  def execute(endpoint, action_id, id, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> String.replace("{actionId}", action_id)
    |> String.replace("{id}", id)
    |> Http.post(body, config)
    |> case do
      {:ok, 202, body} -> {:ok, ActionVersion.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
