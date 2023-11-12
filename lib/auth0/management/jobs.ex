defmodule Auth0.Management.Jobs do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Jobs.Get
  alias Auth0.Management.Jobs.Errors
  alias Auth0.Management.Jobs.UsersExport
  alias Auth0.Management.Jobs.UsersImport
  alias Auth0.Management.Jobs.VerificationEmail

  @type id :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_by_id "/api/v2/jobs/{id}"
  @endpoint_errors "/api/v2/jobs/{id}/errors"
  @endpoint_users_exports "/api/v2/jobs/users-exports"
  @endpoint_users_imports "/api/v2/jobs/users-imports"
  @endpoint_verification_email "/api/v2/jobs/verification-email"

  @doc """
  Get a job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_jobs_by_id

  """
  @spec get(id, config) :: {:ok, Entity.Jobs.t(), response_body} | error
  def get(id, %Config{} = config) do
    Get.execute(@endpoint_by_id, id, config)
  end

  @doc """
  Get job error details.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_errors

  """
  @spec get_error(id, config) :: {:ok, Entity.JobsErrors.t(), response_body} | error
  def get_error(id, %Config{} = config) do
    Errors.Get.execute(@endpoint_errors, id, config)
  end

  @doc """
  Create export users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_exports

  """
  @spec create_users_exports(UsersExport.Params.t() | map, config) ::
          {:ok, Entity.JobsUsersExport.t(), response_body} | error
  def create_users_exports(%{} = params, %Config{} = config) do
    UsersExport.execute(@endpoint_users_exports, params, config)
  end

  @doc """
  Create import users job.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_users_imports

  """
  @spec create_users_imports(UsersImport.Params.t() | map, config) ::
          {:ok, Entity.JobsUsersImport.t(), response_body} | error
  def create_users_imports(%{} = params, %Config{} = config) do
    UsersImport.execute(@endpoint_users_imports, params, config)
  end

  @doc """
  Send an email address verification email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_verification_email

  """
  @spec send_verification_email(VerificationEmail.Params.t() | map, config) ::
          {:ok, Entity.JobsVerificationEmail.t(), response_body} | error
  def send_verification_email(%{} = params, %Config{} = config) do
    VerificationEmail.execute(@endpoint_verification_email, params, config)
  end
end
