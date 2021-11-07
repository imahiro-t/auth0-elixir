defmodule Auth0.Management.RulesConfigs.List do
  @moduledoc """
  Documentation for Auth0 Management Retrieve config variable keys for rules (get_rules-configs).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/get_rules_configs
  """

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.RulesConfigs

  @type endpoint :: String.t()
  @type config :: Config.t()
  @type entity :: RulesConfigs.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Retrieve config variable keys for rules (get_rules-configs).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules_Configs/get_rules_configs

  """
  @spec execute(endpoint, config) :: response
  def execute(endpoint, %Config{} = config) do
    endpoint
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, RulesConfigs.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
