defmodule Auth0.Management.LogStreams do
  @moduledoc """
  Documentation for Auth0 Management API of LogStreams.

  ## endpoint
  - /api/v2/log_streams
  - /api/v2/log_streams/{id}
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.LogStreams.List
  alias Auth0.Management.LogStreams.Create
  alias Auth0.Management.LogStreams.Get
  alias Auth0.Management.LogStreams.Delete
  alias Auth0.Management.LogStreams.Patch

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/log_streams"
  @endpoint_by_id "/api/v2/log_streams/{id}"

  @doc """
  Get log streams.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/get_log_streams

  """
  @spec list(config) :: {:ok, Entity.LogStreams.t(), response_body} | error
  def list(%Config{} = config) do
    List.execute(@endpoint, config)
  end

  @doc """
  Create a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/post_log_streams

  """
  @spec create(Create.Params.t(), config) ::
          {:ok, Entity.LogStream.t(), response_body} | error
  def create(%Create.Params{} = params, %Config{} = config) do
    Create.execute(@endpoint, params, config)
  end

  @doc """
  Get log stream by ID.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/get_log_streams_by_id

  """
  @spec get(id, config) :: {:ok, Entity.LogStream.t(), response_body} | error
  def get(id, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Delete log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/delete_log_streams_by_id

  """
  @spec delete(id, config) :: {:ok, String.t(), response_body} | error
  def delete(id, %Config{} = config) do
    Delete.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Update a log stream.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Log_Streams/patch_log_streams_by_id

  """
  @spec update(id, Patch.Params.t(), config) ::
          {:ok, Entity.LogStream.t(), response_body} | error
  def update(id, %Patch.Params{} = params, %Config{} = config) do
    Patch.execute(@endpoint_by_id, id, params, config)
  end
end
