defmodule Auth0.Entity.GuardianAwsSnsConfiguration do
  @moduledoc """
  Documentation for entity of GuardianAwsSnsConfiguration.

  """

  alias Auth0.Common.Util

  defstruct aws_access_key_id: nil,
            aws_secret_access_key: nil,
            aws_region: nil,
            sns_apns_platform_application_arn: nil,
            sns_gcm_platform_application_arn: nil

  @type t :: %__MODULE__{
          aws_access_key_id: String.t(),
          aws_secret_access_key: String.t(),
          aws_region: String.t(),
          sns_apns_platform_application_arn: String.t(),
          sns_gcm_platform_application_arn: String.t()
        }

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    value |> Util.to_struct(__MODULE__)
  end
end
