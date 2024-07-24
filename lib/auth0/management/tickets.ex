defmodule Auth0.Management.Tickets do
  alias Auth0.Config
  alias Auth0.Management.Tickets.EmailVerification
  alias Auth0.Management.Tickets.PasswordChange

  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Create an email verification ticket for a given user. An email verification ticket is a generated URL that the user can consume to verify their email address.

  ## see
  https://auth0.com/docs/api/management/v2/tickets/post-email-verification

  """
  @spec create_email_verification(map(), config) ::
          {:ok, map()} | error
  def create_email_verification(%{} = params, %Config{} = config) do
    EmailVerification.Create.execute(params, config)
  end

  @doc """
  Create a password change ticket for a given user. A password change ticket is a generated URL that the user can consume to start a reset password flow.

  ## see
  https://auth0.com/docs/api/management/v2/tickets/post-password-change

  """
  @spec create_password_change(map(), config) ::
          {:ok, map()} | error
  def create_password_change(%{} = params, %Config{} = config) do
    PasswordChange.Create.execute(params, config)
  end
end
