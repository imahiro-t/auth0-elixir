defmodule Auth0.Management.Rules.Get do
  @moduledoc """
  Documentation for Auth0 Management Get a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/post_rules
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Rule

  defmodule Params do
    defstruct fields: nil,
              include_fields: nil

    @type t :: %__MODULE__{
            fields: String.t(),
            include_fields: boolean
          }
  end

  @type endpoint :: String.t()
  @type id :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Rule.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/post_rules

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
      {:ok, 200, body} -> {:ok, Rule.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
