defmodule Auth0.Management.Rules do
  @moduledoc """
  Documentation for Auth0 Management API of Rules.

  ## endpoint
  - /api/v2/rules
  - /api/v2/rules/{id}
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Rules.List
  alias Auth0.Management.Rules.Create
  alias Auth0.Management.Rules.Get
  alias Auth0.Management.Rules.Delete
  alias Auth0.Management.Rules.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/rules"
  @endpoint_by_id "/api/v2/rules/{id}"

  @doc """
  Get rules.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/get_rules

  """
  @spec list(List.Params.t() | map, config) :: {:ok, Entity.Rules.t(), response_body} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(@endpoint, params, config)
  end

  @doc """
  Create a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/post_rules

  """
  @spec create(Create.Params.t() | map, config) ::
          {:ok, Entity.Rule.t(), response_body} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Get a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/get_rules_by_id

  """
  @spec get(id, Get.Params.t() | map, config) ::
          {:ok, Entity.Rule.t(), response_body} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, params, config)
  end

  @doc """
  Delete a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/delete_rules_by_id

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Update a rule.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Rules/patch_rules_by_id

  """
  @spec update(id, Patch.Params.t() | map, config) ::
          {:ok, Entity.Rule.t(), response_body} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end
end
