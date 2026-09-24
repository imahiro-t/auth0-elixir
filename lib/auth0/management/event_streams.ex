defmodule Auth0.Management.EventStreams do
  @moduledoc """
  Facade for the Auth0 Management API Event Streams endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.EventStreams.List
  alias Auth0.Management.EventStreams.Create
  alias Auth0.Management.EventStreams.Get
  alias Auth0.Management.EventStreams.Delete
  alias Auth0.Management.EventStreams.Patch
  alias Auth0.Management.EventStreams.Deliveries.List, as: EventStreamsDeliveriesList
  alias Auth0.Management.EventStreams.Deliveries.Get, as: EventStreamsDeliveriesGet
  alias Auth0.Management.EventStreams.Redeliver.Create, as: EventStreamsRedeliverCreate
  alias Auth0.Management.EventStreams.Redeliver.CreateById, as: EventStreamsRedeliverCreateById
  alias Auth0.Management.EventStreams.Test, as: EventStreamsTest

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

  @doc """
  Get this event stream's delivery history.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/get-event-deliveries

  """
  @spec list_deliveries(String.t(), map(), config) :: {:ok, map()} | error
  def list_deliveries(id, %{} = params, %Config{} = config) do
    EventStreamsDeliveriesList.execute(id, params, config)
  end

  @doc """
  Get a specific event's delivery history.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/get-deliveries-by-event-id

  """
  @spec get_delivery(String.t(), String.t(), config) :: {:ok, map()} | error
  def get_delivery(id, event_id, %Config{} = config) do
    EventStreamsDeliveriesGet.execute(id, event_id, config)
  end

  @doc """
  Redeliver failed events.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/post-redeliver

  """
  @spec redeliver(String.t(), map(), config) :: {:ok, map()} | error
  def redeliver(id, %{} = params, %Config{} = config) do
    EventStreamsRedeliverCreate.execute(id, params, config)
  end

  @doc """
  Redeliver a single failed event by ID.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/post-redeliver-by-event-id

  """
  @spec redeliver_by_id(String.t(), String.t(), config) :: {:ok, String.t()} | error
  def redeliver_by_id(id, event_id, %Config{} = config) do
    EventStreamsRedeliverCreateById.execute(id, event_id, config)
  end

  @doc """
  Send a test event to an event stream.

  ## see
  https://auth0.com/docs/api/management/v2/event-streams/post-test-event

  """
  @spec test(String.t(), map(), config) :: {:ok, map()} | error
  def test(id, %{} = params, %Config{} = config) do
    EventStreamsTest.execute(id, params, config)
  end
end
