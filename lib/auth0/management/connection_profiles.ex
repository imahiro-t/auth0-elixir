defmodule Auth0.Management.ConnectionProfiles do
  @moduledoc """
  Facade for the Auth0 Management API Connection Profiles endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.ConnectionProfiles.List
  alias Auth0.Management.ConnectionProfiles.Get
  alias Auth0.Management.ConnectionProfiles.Patch
  alias Auth0.Management.ConnectionProfiles.Create, as: ConnectionProfilesCreate
  alias Auth0.Management.ConnectionProfiles.Templates.List, as: ConnectionProfilesTemplatesList
  alias Auth0.Management.ConnectionProfiles.Templates.Get, as: ConnectionProfilesTemplatesGet
  alias Auth0.Management.ConnectionProfiles.Delete, as: ConnectionProfilesDelete

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve a list of connection profiles.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profiles
  """
  @spec list(map(), config) :: {:ok, list(map())} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Retrieve a connection profile by its ID.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profiles-by-id
  """
  @spec get(id, config) :: {:ok, map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Update a connection profile.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/patch-connection-profiles-by-id
  """
  @spec update(id, map(), config) :: {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Create a connection profile.

  Create a Connection Profile.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/post-connection-profiles

  """
  @spec create(map(), config) :: {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    ConnectionProfilesCreate.execute(params, config)
  end

  @doc """
  Get Connection Profile Templates.

  Retrieve a list of Connection Profile Templates.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profile-templates

  """
  @spec list_templates(config) :: {:ok, map()} | error
  def list_templates(%Config{} = config) do
    ConnectionProfilesTemplatesList.execute(config)
  end

  @doc """
  Get Connection Profile Template.

  Retrieve a Connection Profile Template.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/get-connection-profile-template

  """
  @spec get_template(String.t(), config) :: {:ok, map()} | error
  def get_template(id, %Config{} = config) do
    ConnectionProfilesTemplatesGet.execute(id, config)
  end

  @doc """
  Delete Connection Profile.

  Delete a single Connection Profile specified by ID.

  ## see
  https://auth0.com/docs/api/management/v2/connection-profiles/delete-connection-profiles-by-id

  """
  @spec delete(String.t(), config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    ConnectionProfilesDelete.execute(id, config)
  end
end
