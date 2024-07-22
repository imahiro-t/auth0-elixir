defmodule Auth0.Management.Prompts do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Management.Prompts.Get
  alias Auth0.Management.Prompts.Patch
  alias Auth0.Management.Prompts.CustomText
  alias Auth0.Management.Prompts.Partials

  @type prompt :: String.t()
  @type language :: String.t()
  @type config :: Config.t()
  @type error :: {:error, integer, term} | {:error, term}

  @doc """
  Retrieve details of the Universal Login configuration of your tenant. This includes the Identifier First Authentication and WebAuthn with Device Biometrics for MFA features.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-prompts

  """
  @spec get(config) ::
          {:ok, list() | map()} | error
  def get(%Config{} = config) do
    Get.execute(config)
  end

  @doc """
  Update the Universal Login configuration of your tenant. This includes the Identifier First Authentication and WebAuthn with Device Biometrics for MFA features.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/patch-prompts

  """
  @spec update(map(), config) ::
          {:ok, list() | map()} | error
  def update(%{} = params, %Config{} = config) do
    Patch.execute(params, config)
  end

  @doc """
  Retrieve custom text for a specific prompt and language.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-custom-text-by-language

  """
  @spec get_custom_text(prompt, language, config) ::
          {:ok, list() | map()} | error
  def get_custom_text(prompt, language, %Config{} = config) do
    CustomText.Get.execute(prompt, language, config)
  end

  @doc """
  Set custom text for a specific prompt. Existing texts will be overwritten.

  ## see
  https://auth0.com/docs/api/management/v2/prompts/put-custom-text-by-language

  """
  @spec set_custom_text(prompt, language, map(), config) ::
          {:ok, list() | map()} | error
  def set_custom_text(prompt, language, %{} = params, %Config{} = config) do
    CustomText.Put.execute(prompt, language, params, config)
  end

  @doc """
  Get template partials for a prompt

  ## see
  https://auth0.com/docs/api/management/v2/prompts/get-partials

  """
  @spec get_partials(prompt, config) ::
          {:ok, list() | map()} | error
  def get_partials(prompt, %Config{} = config) do
    Partials.Get.execute(prompt, config)
  end

  @doc """
  Set template partials for a prompt

  ## see
  https://auth0.com/docs/api/management/v2/prompts/put-partials

  """
  @spec set_partials(prompt, map(), config) ::
          {:ok, list() | map()} | error
  def set_partials(prompt, %{} = params, %Config{} = config) do
    Partials.Put.execute(prompt, params, config)
  end
end
