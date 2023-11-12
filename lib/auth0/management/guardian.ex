defmodule Auth0.Management.Guardian do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Guardian.Factors
  alias Auth0.Management.Guardian.Policies
  alias Auth0.Management.Guardian.Enrollments
  alias Auth0.Management.Guardian.Phone
  alias Auth0.Management.Guardian.Sms
  alias Auth0.Management.Guardian.Twilio
  alias Auth0.Management.Guardian.AwsSns

  @type id :: String.t()
  @type name :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint_factors "/api/v2/guardian/factors"
  @endpoint_factors_by_name "/api/v2/guardian/factors/{name}"
  @endpoint_policies "/api/v2/guardian/policies"
  @endpoint_enrollment_by_id "/api/v2/guardian/enrollments/{id}"
  @endpoint_phone_factor "/api/v2/guardian/factors/phone/message-types"
  @endpoint_phone_configuration "/api/v2/guardian/factors/phone/selected-provider"
  @endpoint_phone_template "/api/v2/guardian/factors/phone/templates"
  @endpoint_sms_configuration "/api/v2/guardian/factors/sms/selected-provider"
  @endpoint_sms_template "/api/v2/guardian/factors/sms/templates"
  @endpoint_twilio_phone_configuration "/api/v2/guardian/factors/phone/providers/twilio"
  @endpoint_twilio_sms_configuration "/api/v2/guardian/factors/sms/providers/twilio"
  @endpoint_aws_sns_configuration "/api/v2/guardian/factors/push-notification/providers/sns"
  @endpoint_enrollment_ticket "/api/v2/guardian/enrollments/ticket"

  @doc """
  Retrieve Factors and their Status.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_factors

  """
  @spec list_factors(config) ::
          {:ok, Entity.GuardianFactors.t(), response_body} | error
  def list_factors(%Config{} = config) do
    Factors.List.execute(@endpoint_factors, config)
  end

  @doc """
  Update a Multi-factor Authentication Factor.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_factors_by_name

  """
  @spec update_factor(name, Factors.Put.Params.t() | map, config) ::
          {:ok, Entity.GuardianFactor.t(), response_body} | error
  def update_factor(name, %{} = params, %Config{} = config) do
    Factors.Put.execute(@endpoint_factors_by_name, name, params, config)
  end

  @doc """
  Get the Multi-factor Authentication policies.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_policies

  """
  @spec list_policies(config) :: {:ok, list(map), response_body} | error
  def list_policies(%Config{} = config) do
    Policies.List.execute(@endpoint_policies, config)
  end

  @doc """
  Set the Multi-factor Authentication policies.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_policies

  """
  @spec set_policies(map, config) :: {:ok, list(map), response_body} | error
  def set_policies(params, %Config{} = config) do
    Policies.Put.execute(@endpoint_policies, params, config)
  end

  @doc """
  Retrieve a multi-factor authentication enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_enrollments_by_id

  """
  @spec get_enrollment(id, config) ::
          {:ok, Entity.GuardianEnrollment.t(), response_body} | error
  def get_enrollment(id, %Config{} = config) do
    Enrollments.Get.execute(@endpoint_enrollment_by_id, id, config)
  end

  @doc """
  Delete a multi-factor authentication enrollment.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/delete_enrollments_by_id

  """
  @spec delete_enrollment(id, config) :: {:ok, String.t(), response_body} | error
  def delete_enrollment(id, %Config{} = config) do
    Enrollments.Delete.execute(@endpoint_enrollment_by_id, id, config)
  end

  @doc """
  Create a multi-factor authentication enrollment ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/post_ticket

  """
  @spec create_enrollment_ticket(Enrollments.Ticket.Params.t() | map, config) ::
          {:ok, Entity.GuardianEnrollmentTicket.t(), response_body} | error
  def create_enrollment_ticket(%{} = params, %Config{} = config) do
    Enrollments.Ticket.execute(@endpoint_enrollment_ticket, params, config)
  end

  @doc """
  Retrieve the Enabled Phone Factors.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_message_types

  """
  @spec get_phone_factor(config) ::
          {:ok, Entity.GuardianPhoneFactor.t(), response_body} | error
  def get_phone_factor(%Config{} = config) do
    Phone.Factor.Get.execute(@endpoint_phone_factor, config)
  end

  @doc """
  Update the Enabled Phone Factors.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_message_types

  """
  @spec update_phone_factor(Phone.Factor.Put.Params.t() | map, config) ::
          {:ok, Entity.GuardianPhoneFactor.t(), response_body} | error
  def update_phone_factor(%{} = params, %Config{} = config) do
    Phone.Factor.Put.execute(@endpoint_phone_factor, params, config)
  end

  @doc """
  Retrieve phone configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_selected_provider

  """
  @spec get_phone_configuration(config) ::
          {:ok, Entity.GuardianPhoneConfiguration.t(), response_body} | error
  def get_phone_configuration(%Config{} = config) do
    Phone.Configuration.Get.execute(@endpoint_phone_configuration, config)
  end

  @doc """
  Update phone configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_selected_provider

  """
  @spec update_phone_configuration(Phone.Configuration.Put.Params.t() | map, config) ::
          {:ok, Entity.GuardianPhoneConfiguration.t(), response_body} | error
  def update_phone_configuration(%{} = params, %Config{} = config) do
    Phone.Configuration.Put.execute(@endpoint_phone_configuration, params, config)
  end

  @doc """
  Retrieve Enrollment and Verification Phone Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_templates

  """
  @spec get_phone_template(config) ::
          {:ok, Entity.GuardianPhoneTemplate.t(), response_body} | error
  def get_phone_template(%Config{} = config) do
    Phone.Template.Get.execute(@endpoint_phone_template, config)
  end

  @doc """
  Update Enrollment and Verification Phone Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_templates

  """
  @spec update_phone_template(Phone.Template.Put.Params.t() | map, config) ::
          {:ok, Entity.GuardianPhoneTemplate.t(), response_body} | error
  def update_phone_template(%{} = params, %Config{} = config) do
    Phone.Template.Put.execute(@endpoint_phone_template, params, config)
  end

  @doc """
  Retrieve SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_selected_provider_0

  """
  @spec get_sms_configuration(config) ::
          {:ok, Entity.GuardianSmsConfiguration.t(), response_body} | error
  def get_sms_configuration(%Config{} = config) do
    Sms.Configuration.Get.execute(@endpoint_sms_configuration, config)
  end

  @doc """
  Update SMS configuration (one of auth0|twilio|phone-message-hook).

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_selected_provider_0

  """
  @spec update_sms_configuration(Sms.Configuration.Put.Params.t() | map, config) ::
          {:ok, Entity.GuardianSmsConfiguration.t(), response_body} | error
  def update_sms_configuration(%{} = params, %Config{} = config) do
    Sms.Configuration.Put.execute(@endpoint_sms_configuration, params, config)
  end

  @doc """
  Retrieve SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_templates_0

  """
  @spec get_sms_template(config) ::
          {:ok, Entity.GuardianSmsTemplate.t(), response_body} | error
  def get_sms_template(%Config{} = config) do
    Sms.Template.Get.execute(@endpoint_sms_template, config)
  end

  @doc """
  Update SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_templates_0

  """
  @spec update_sms_template(Sms.Template.Put.Params.t() | map, config) ::
          {:ok, Entity.GuardianSmsTemplate.t(), response_body} | error
  def update_sms_template(%{} = params, %Config{} = config) do
    Sms.Template.Put.execute(@endpoint_sms_template, params, config)
  end

  @doc """
  Retrieve Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio

  """
  @spec get_twilio_phone_configuration(config) ::
          {:ok, Entity.GuardianTwilioConfiguration.t(), response_body} | error
  def get_twilio_phone_configuration(%Config{} = config) do
    Twilio.Phone.Configuration.Get.execute(@endpoint_twilio_phone_configuration, config)
  end

  @doc """
  Update Twilio phone configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio

  """
  @spec update_twilio_phone_configuration(Twilio.Phone.Configuration.Put.Params.t() | map, config) ::
          {:ok, Entity.GuardianTwilioConfiguration.t(), response_body} | error
  def update_twilio_phone_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Twilio.Phone.Configuration.Put.execute(@endpoint_twilio_phone_configuration, params, config)
  end

  @doc """
  Retrieve Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_twilio_0

  """
  @spec get_twilio_sms_configuration(config) ::
          {:ok, Entity.GuardianTwilioConfiguration.t(), response_body} | error
  def get_twilio_sms_configuration(%Config{} = config) do
    Twilio.Sms.Configuration.Get.execute(@endpoint_twilio_sms_configuration, config)
  end

  @doc """
  Update Twilio SMS configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_twilio_0

  """
  @spec update_twilio_sms_configuration(Twilio.Sms.Configuration.Put.Params.t() | map, config) ::
          {:ok, Entity.GuardianTwilioConfiguration.t(), response_body} | error
  def update_twilio_sms_configuration(
        %{} = params,
        %Config{} = config
      ) do
    Twilio.Sms.Configuration.Put.execute(@endpoint_twilio_sms_configuration, params, config)
  end

  @doc """
  Retrieve AWS SNS push notification configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/get_sns

  """
  @spec get_aws_sns_configuration(config) ::
          {:ok, Entity.GuardianAwsSnsConfiguration.t(), response_body} | error
  def get_aws_sns_configuration(%Config{} = config) do
    AwsSns.Configuration.Get.execute(@endpoint_aws_sns_configuration, config)
  end

  @doc """
  Update SNS configuration for push notifications.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/patch_sns

  """
  @spec patch_aws_sns_configuration(AwsSns.Configuration.Patch.Params.t() | map, config) ::
          {:ok, Entity.GuardianAwsSnsConfiguration.t(), response_body} | error
  def patch_aws_sns_configuration(
        %{} = params,
        %Config{} = config
      ) do
    AwsSns.Configuration.Patch.execute(@endpoint_aws_sns_configuration, params, config)
  end

  @doc """
  Update AWS SNS push notification configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_sns

  """
  @spec update_aws_sns_configuration(AwsSns.Configuration.Put.Params.t() | map, config) ::
          {:ok, Entity.GuardianAwsSnsConfiguration.t(), response_body} | error
  def update_aws_sns_configuration(
        %{} = params,
        %Config{} = config
      ) do
    AwsSns.Configuration.Put.execute(@endpoint_aws_sns_configuration, params, config)
  end
end
