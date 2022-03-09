defmodule Auth0.Entity.AttackProtectionSuspiciousIpThrottling do
  @moduledoc """
  Documentation for entity of AttackProtectionSuspiciousIpThrottling.

  """

  defmodule Stage do
    @moduledoc """
    Documentation for entity of AttackProtectionSuspiciousIpThrottling Stage.

    """
    defmodule PreLogin do
      @moduledoc """
      Documentation for entity of AttackProtectionSuspiciousIpThrottling PreLogin.

      """

      alias Auth0.Common.Util

      defstruct max_attempts: nil,
                rate: nil

      @type t :: %__MODULE__{
              max_attempts: integer,
              rate: integer
            }

      @spec from(map) :: __MODULE__.t()
      def from(value) do
        value |> Util.to_struct(__MODULE__)
      end
    end

    defmodule PreUserRegistration do
      @moduledoc """
      Documentation for entity of AttackProtectionSuspiciousIpThrottling PreUserRegistration.

      """

      alias Auth0.Common.Util

      defstruct max_attempts: nil,
                rate: nil

      @type t :: %__MODULE__{
              max_attempts: integer,
              rate: integer
            }

      @spec from(map) :: __MODULE__.t()
      def from(value) do
        value |> Util.to_struct(__MODULE__)
      end
    end

    alias Auth0.Common.Util

    defstruct "pre-login": nil,
              "pre-user-registration": nil

    @type t :: %__MODULE__{
            "pre-login": PreLogin.t(),
            "pre-user-registration": PreUserRegistration.t()
          }

    @spec from(map) :: __MODULE__.t()
    def from(value) do
      response = value |> Util.to_struct(__MODULE__)

      %{
        response
        | "pre-login":
            if(response."pre-login" |> is_map,
              do: response."pre-login" |> PreLogin.from(),
              else: nil
            ),
          "pre-user-registration":
            if(response."pre-user-registration" |> is_map,
              do: response."pre-user-registration" |> PreUserRegistration.from(),
              else: nil
            )
      }
    end
  end

  alias Auth0.Common.Util

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

  @spec from(map) :: __MODULE__.t()
  def from(value) do
    attack_protection_suspicious_ip_throttling = value |> Util.to_struct(__MODULE__)

    %{
      attack_protection_suspicious_ip_throttling
      | stage:
          if(attack_protection_suspicious_ip_throttling.stage |> is_map,
            do: attack_protection_suspicious_ip_throttling.stage |> Stage.from(),
            else: nil
          )
    }
  end
end
