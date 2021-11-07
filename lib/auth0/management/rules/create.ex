defmodule Auth0.Management.Rules.Create do
  @moduledoc """
  Documentation for Auth0 Management Create a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/post_rules
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Rule

  defmodule Params do
    defstruct name: nil,
              enabled: nil,
              script: nil,
              order: nil

    @type t :: %__MODULE__{
            name: String.t(),
            enabled: boolean,
            script: String.t(),
            order: integer
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Rule.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/post_rules

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, Rule.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
