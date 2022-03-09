defmodule Auth0.Management.AttackProtection.SuspiciousIpThrottling.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_suspicious_ip_throttling
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.AttackProtectionSuspiciousIpThrottling

  defmodule Params do
    defmodule Stage do
      defmodule PreLogin do
        defstruct max_attempts: nil,
                  rate: nil

        @type t :: %__MODULE__{
                max_attempts: integer,
                rate: integer
              }
      end

      defmodule PreUserRegistration do
        defstruct max_attempts: nil,
                  rate: nil

        @type t :: %__MODULE__{
                max_attempts: integer,
                rate: integer
              }
      end

      alias Auth0.Common.Util

      defstruct pre_login: nil,
                pre_user_registration: nil

      @type t :: %__MODULE__{
              pre_login: PreLogin.t(),
              pre_user_registration: PreUserRegistration.t()
            }
    end

    defstruct enabled: nil,
              shields: nil,
              allowlist: nil,
              stage: nil

    @type t :: %__MODULE__{
            enabled: boolean,
            shields: list(String.t()),
            allowlist: list(String.t()),
            stage: Stage.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: AttackProtectionSuspiciousIpThrottling.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_suspicious_ip_throttling

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    Http.patch(endpoint, body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, AttackProtectionSuspiciousIpThrottling.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
