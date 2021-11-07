defmodule Auth0.Management.Tickets do
  @moduledoc """
  Documentation for Auth0 Management API of Tickets.

  ## endpoint
  - /api/v2/tickets/email-verification
  - /api/v2/tickets/password-change
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Tickets.EmailVerification
  alias Auth0.Management.Tickets.PasswordChange

  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_email_verification "/api/v2/tickets/email-verification"
  @endpoint_password_change "/api/v2/tickets/password-change"

  @doc """
  Create an email verification ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_email_verification

  """
  @spec create_email_verification(EmailVerification.Create.Params.t(), config) ::
          {:ok, Entity.Ticket.t(), response_body} | error
  def create_email_verification(%EmailVerification.Create.Params{} = params, %Config{} = config) do
    EmailVerification.Create.execute(@endpoint_email_verification, params, config)
  end

  @doc """
  Create a password change ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_password_change

  """
  @spec create_password_change(PasswordChange.Create.Params.t(), config) ::
          {:ok, Entity.Ticket.t(), response_body} | error
  def create_password_change(%PasswordChange.Create.Params{} = params, %Config{} = config) do
    PasswordChange.Create.execute(@endpoint_password_change, params, config)
  end
end
