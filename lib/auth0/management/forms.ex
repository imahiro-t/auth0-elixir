defmodule Auth0.Management.Forms do
  @moduledoc """
  Facade for the Auth0 Management API Forms endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

  alias Auth0.Config
  alias Auth0.Management.Forms.List
  alias Auth0.Management.Forms.Create
  alias Auth0.Management.Forms.Get
  alias Auth0.Management.Forms.Patch
  alias Auth0.Management.Forms.Delete, as: FormsDelete

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Get forms.

  ## see
  https://auth0.com/docs/api/management/v2/forms/get-forms

  """
  @spec list(map(), config) ::
          {:ok, map()} | error
  def list(%{} = params, %Config{} = config) do
    List.execute(params, config)
  end

  @doc """
  Create a form.

  ## see
  https://auth0.com/docs/api/management/v2/forms/post-forms

  """
  @spec create(map(), config) ::
          {:ok, map()} | error
  def create(%{} = params, %Config{} = config) do
    Create.execute(params, config)
  end

  @doc """
  Get a form.

  ## see
  https://auth0.com/docs/api/management/v2/forms/get-forms-by-id

  """
  @spec get(id, map(), config) ::
          {:ok, map()} | error
  def get(id, %{} = params, %Config{} = config) do
    Get.execute(id, params, config)
  end

  @doc """
  Update a form.

  ## see
  https://auth0.com/docs/api/management/v2/forms/patch-forms-by-id

  """
  @spec update(id, map(), config) ::
          {:ok, map()} | error
  def update(id, %{} = params, %Config{} = config) do
    Patch.execute(id, params, config)
  end

  @doc """
  Delete a form.

  ## see
  https://auth0.com/docs/api/management/v2/forms/delete-form

  """
  @spec delete(String.t(), config) :: {:ok, String.t()} | error
  def delete(id, %Config{} = config) do
    FormsDelete.execute(id, config)
  end
end
