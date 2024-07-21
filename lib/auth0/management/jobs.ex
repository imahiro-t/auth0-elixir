defmodule Auth0.Management.Jobs do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Jobs.Get
  alias Auth0.Management.Jobs.Errors
  alias Auth0.Management.Jobs.UsersExport
  alias Auth0.Management.Jobs.UsersImport
  alias Auth0.Management.Jobs.VerificationEmail

  @type id :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieves a job. Useful to check its status.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/get-jobs-by-id

  """
  @spec get(id, config) ::
          {:ok, list() | map()} | error
  def get(id, %Config{} = config) do
    Get.execute(id, config)
  end

  @doc """
  Retrieve error details of a failed job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/get-errors

  """
  @spec get_error(id, config) ::
          {:ok, list() | map()} | error
  def get_error(id, %Config{} = config) do
    Errors.Get.execute(id, config)
  end

  @doc """
  Export all users to a file via a long-running job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-users-exports

  """
  @spec create_users_exports(map(), config) ::
          {:ok, list() | map()} | error
  def create_users_exports(%{} = params, %Config{} = config) do
    UsersExport.execute(params, config)
  end

  @doc """
  Import users from a formatted file into a connection via a long-running job.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-users-imports

  """
  @spec create_users_imports(map(), config) ::
          {:ok, list() | map()} | error
  def create_users_imports(%{} = params, %Config{} = config) do
    UsersImport.execute(params, config)
  end

  @doc """
  Send an email to the specified user that asks them to click a link to verify their email address.

  ## see
  https://auth0.com/docs/api/management/v2/jobs/post-verification-email

  """
  @spec send_verification_email(map(), config) ::
          {:ok, list() | map()} | error
  def send_verification_email(%{} = params, %Config{} = config) do
    VerificationEmail.execute(params, config)
  end
end
