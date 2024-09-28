defmodule Auth0.Management.Flows do
  alias Auth0.Config
  alias Auth0.Management.Flows.List
  alias Auth0.Management.Flows.Create
  alias Auth0.Management.Flows.Get
  alias Auth0.Management.Flows.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Get flows.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows

  """
  @spec list(map(), config) ::
          {:ok, map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a flow.

  ## see
  https://auth0.com/docs/api/management/v2/flows/post-flows

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Get a flow.

  ## see
  https://auth0.com/docs/api/management/v2/flows/get-flows-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(id, params, config)
  end

  @doc """
  Update a flow.

  ## see
  https://auth0.com/docs/api/management/v2/flows/patch-flows-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
