defmodule Auth0.Management.Tickets do
  @moduledoc """
  Facade for the Auth0 Management API Tickets endpoints.

  Most applications should call `Auth0.Api.Management` instead of this module.
  """

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
  @spec create_email_verification(map(), config, keyword()) ::
          {:ok, map()} | error
  def create_email_verification(%{} = params, %Config{} = config, opts \\ []) do
    EmailVerification.Create.execute(params, config, opts)
  end

  @doc """
  Create a password change ticket for a given user. A password change ticket is a generated URL that the user can consume to start a reset password flow.

  ## see
  https://auth0.com/docs/api/management/v2/tickets/post-password-change

  """
  @spec create_password_change(map(), config, keyword()) ::
          {:ok, map()} | error
  def create_password_change(%{} = params, %Config{} = config, opts \\ []) do
    PasswordChange.Create.execute(params, config, opts)
  end
end
