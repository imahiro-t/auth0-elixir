defmodule Auth0.Management.SupplementalSignals do
  alias Auth0.Config
  alias Auth0.Management.SupplementalSignals.Create
  alias Auth0.Management.SupplementalSignals.Get

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Create a supplemental signal.

  ## see
  https://auth0.com/docs/api/management/v2/supplemental-signals/post-supplemental-signals
  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve a supplemental signal by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/supplemental-signals/get-supplemental-signals-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end
end
