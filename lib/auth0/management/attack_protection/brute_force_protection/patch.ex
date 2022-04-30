defmodule Auth0.Management.AttackProtection.BruteForceProtection.Patch do
  @moduledoc """
  Documentation for Auth0 Management Update the brute force configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_brute_force_protection
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.AttackProtectionBruteForceProtection

  defmodule Params do
    defstruct enabled: nil,
              shields: nil,
              allowlist: nil,
              mode: nil,
              max_attempts: nil

    @type t :: %__MODULE__{
            enabled: boolean,
            shields: list(String.t()),
            allowlist: list(String.t()),
            mode: String.t(),
            max_attempts: integer
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: AttackProtectionBruteForceProtection.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update the brute force configuration.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Attack_Protection/patch_brute_force_protection

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
        {:ok, AttackProtectionBruteForceProtection.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
