defmodule Auth0.Management.EventStreams do
  alias Auth0.Config
  alias Auth0.Management.EventStreams.List
  alias Auth0.Management.EventStreams.Create
  alias Auth0.Management.EventStreams.Get
  alias Auth0.Management.EventStreams.Delete
  alias Auth0.Management.EventStreams.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve all event streams.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/get-event-streams
  """
  @spec list(map(), config) :: {:ok, list(map())} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create an event stream.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/post-event-streams
  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve an event stream by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/get-event-streams-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Delete an event stream.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/delete-event-streams-by-id
  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update an event stream.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/patch-event-streams-by-id
  """
  @spec update(id, map(), config) :: {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
