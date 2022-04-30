defmodule Auth0.Management.Guardian.AwsSns.Configuration.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update AWS SNS push notification configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_sns
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianAwsSnsConfiguration

  defmodule Params do
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
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: GuardianAwsSnsConfiguration.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update AWS SNS push notification configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_sns

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> Http.patch(body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, GuardianAwsSnsConfiguration.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
