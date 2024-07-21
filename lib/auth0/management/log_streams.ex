defmodule Auth0.Management.LogStreams do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.LogStreams.List
  alias Auth0.Management.LogStreams.Create
  alias Auth0.Management.LogStreams.Get
  alias Auth0.Management.LogStreams.Delete
  alias Auth0.Management.LogStreams.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details on log streams.

  ## see
  https://auth0.com/docs/api/management/v2/log-streams/get-log-streams

  """
  @spec list(config) ::
          {:ok, list() | map()} | error
  def list(%Config{} = config) do
    List.execute(config)
  end

  @doc """
  Create a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/log-streams/post-log-streams

  """
  @spec create(map(), config) ::
          {:ok, list() | map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Retrieve a log stream configuration and status.

  ## see
  https://auth0.com/docs/api/management/v2#!/Log_Streams/get_log_streams_by_id

  """
  @spec get(id, config) ::
          {:ok, list() | map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Delete a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/log-streams/delete-log-streams-by-id

  """
  @spec delete(id, config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    Delete.execute(id, config)
  end

  @doc """
  Update a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/log-streams/patch-log-streams-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, list() | map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end
end
