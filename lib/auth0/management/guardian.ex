defmodule Auth0.Management.Guardian do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Guardian.Factors
  alias Auth0.Management.Guardian.Policies
  alias Auth0.Management.Guardian.Enrollments
  alias Auth0.Management.Guardian.Phone
  alias Auth0.Management.Guardian.Twilio
  alias Auth0.Management.Guardian.AwsSns

  @type id :: String.t()
  @type name :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details of all multi-factor authentication factors associated with your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-factors

  """
  @spec list_factors(config) ::
          {:ok, list() | map()} | error
  def list_factors(%Config{} = config) do
    Factors.List.execute(config)
  end

  @doc """
  Update the status (i.e., enabled or disabled) of a specific multi-factor authentication factor.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-factors-by-name

  """
  @spec update_factor(name, map(), config) ::
          {:ok, list() | map()} | error
  def update_factor(name, %{} = params, %Config{} = config) do
    Factors.Put.execute(name, params, config)
  end

  @doc """
  Retrieve the multi-factor authentication (MFA) policies configured for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-policies

  """
  @spec list_policies(config) :: {:ok, list(map)} | error
  def list_policies(%Config{} = config) do
    Policies.List.execute(config)
  end

  @doc """
  Set multi-factor authentication (MFA) policies for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-policies

  """
  @spec set_policies(map, config) :: {:ok, list(map)} | error
  def set_policies(params, %Config{} = config) do
    Policies.Put.execute(params, config)
  end

  @doc """
  Retrieve details, such as status and type, for a specific multi-factor authentication enrollment registered to a user account.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-enrollments-by-id

  """
  @spec get_enrollment(id, config) ::
          {:ok, list() | map()} | error
  def get_enrollment(id, %Config{} = config) do
    Enrollments.Get.execute(id, config)
  end

  @doc """
  Remove a specific multi-factor authentication (MFA) enrollment from a user's account. This allows the user to re-enroll with MFA.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/delete-enrollments-by-id

  """
  @spec delete_enrollment(id, config) :: {:ok, String.t()} | error
  def delete_enrollment(id, %Config{} = config) do
    Enrollments.Delete.execute(id, config)
  end

  @doc """
  Create a multi-factor authentication (MFA) enrollment ticket, and optionally send an email with the created ticket, to a given user.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/post-ticket

  """
  @spec create_enrollment_ticket(map(), config) ::
          {:ok, list() | map()} | error
  def create_enrollment_ticket(%{} = params, %Config{} = config) do
    Enrollments.Ticket.execute(params, config)
  end

  @doc """
  Retrieve list of phone-type MFA factors (i.e., sms and voice) that are enabled for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-message-types

  """
  @spec get_phone_factor(config) ::
          {:ok, list() | map()} | error
  def get_phone_factor(%Config{} = config) do
    Phone.Factor.Get.execute(config)
  end

  @doc """
  Replace the list of phone-type MFA factors (i.e., sms and voice) that are enabled for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-message-types

  """
  @spec update_phone_factor(map(), config) ::
          {:ok, list() | map()} | error
  def update_phone_factor(%{} = params, %Config{} = config) do
    Phone.Factor.Put.execute(params, config)
  end

  @doc """
  Retrieve details of the multi-factor authentication phone provider configured for your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-guardian-phone-providers

  """
  @spec get_phone_configuration(config) ::
          {:ok, list() | map()} | error
  def get_phone_configuration(%Config{} = config) do
    Phone.Configuration.Get.execute(config)
  end

  @doc """
  Update phone provider configuration

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-phone-providers

  """
  @spec update_phone_configuration(map(), config) ::
          {:ok, list() | map()} | error
  def update_phone_configuration(%{} = params, %Config{} = config) do
    Phone.Configuration.Put.execute(params, config)
  end

  @doc """
  Retrieve details of the multi-factor authentication enrollment and verification templates for phone-type factors available in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-factor-phone-templates

  """
  @spec get_phone_template(config) ::
          {:ok, list() | map()} | error
  def get_phone_template(%Config{} = config) do
    Phone.Template.Get.execute(config)
  end

  @doc """
  Customize the messages sent to complete phone enrollment and verification (subscription required).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-factor-phone-templates

  """
  @spec update_phone_template(map(), config) ::
          {:ok, list() | map()} | error
  def update_phone_template(%{} = params, %Config{} = config) do
    Phone.Template.Put.execute(params, config)
  end

  @doc """
  Retrieve configuration details for a Twilio phone provider that has been set up in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-phone-twilio-factor-provider

  """
  @spec get_twilio_phone_configuration(config) ::
          {:ok, list() | map()} | error
  def get_twilio_phone_configuration(%Config{} = config) do
    Twilio.Phone.Configuration.Get.execute(config)
  end

  @doc """
  Update the configuration of a Twilio phone provider that has been set up in your tenant.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-twilio

  """
  @spec update_twilio_phone_configuration(map(), config) ::
          {:ok, list() | map()} | error
  def update_twilio_phone_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Twilio.Phone.Configuration.Put.execute(params, config)
  end

  @doc """
  Retrieve configuration details for an AWS SNS push notification provider that has been enabled for MFA.

  ## see
  https://auth0.com/docs/api/management/v2/guardian/get-sns

  """
  @spec get_aws_sns_configuration(config) ::
          {:ok, list() | map()} | error
  def get_aws_sns_configuration(%Config{} = config) do
    AwsSns.Configuration.Get.execute(config)
  end

  @doc """
  Configure the AWS SNS push notification provider configuration (subscription required).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/patch-sns

  """
  @spec patch_aws_sns_configuration(map(), config) ::
          {:ok, list() | map()} | error
  def patch_aws_sns_configuration(
        %{} = params,
        %Config{} = config
      ) do
    AwsSns.Configuration.Patch.execute(params, config)
  end

  @doc """
  Configure the AWS SNS push notification provider configuration (subscription required).

  ## see
  https://auth0.com/docs/api/management/v2/guardian/put-sns

  """
  @spec update_aws_sns_configuration(map(), config) ::
          {:ok, list() | map()} | error
  def update_aws_sns_configuration(
        %{} = params,
        %Config{} = config
      ) do
    AwsSns.Configuration.Put.execute(params, config)
  end
end
