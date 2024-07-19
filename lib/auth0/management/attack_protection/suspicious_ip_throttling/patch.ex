defmodule Auth0.Management.AttackProtection.SuspiciousIpThrottling.Patch do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defmodule Stage do
      @moduledoc false
      defmodule PreLogin do
        @moduledoc false
        defstruct max_attempts: nil,
                  rate: nil

        @type t :: %__MODULE__{
                max_attempts: integer,
                rate: integer
              }
      end

      defmodule PreUserRegistration do
        @moduledoc false
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
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Update the suspicious IP throttling configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_suspicious_ip_throttling

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.patch(endpoint, body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, body |> Jason.decode!()}

      error ->
        error
    end
  end
end
