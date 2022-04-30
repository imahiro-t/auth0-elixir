defmodule Auth0.Management.AttackProtection.BreachedPasswordDetection.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update breached password detection settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_breached_password_detection
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.AttackProtectionBreachedPasswordDetection

  defmodule Params do
    defstruct enabled: nil,
              shields: nil,
              admin_notification_frequency: nil,
              method: nil

    @type t :: %__MODULE__{
            enabled: boolean,
            shields: list(String.t()),
            admin_notification_frequency: list(String.t()),
            method: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: AttackProtectionBreachedPasswordDetection.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update breached password detection settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_breached_password_detection

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
        {:ok, AttackProtectionBreachedPasswordDetection.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
