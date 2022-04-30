defmodule Auth0.Management.Prompts do
  @moduledoc """
  Documentation for Auth0 Management API of Prompts.

  ## endpoint
  - /api/v2/prompts
  - /api/v2/prompts/{prompt}/custom-text/{language}
  """

  alias Auth0.Config
  alias Auth0.Entity
  alias Auth0.Management.Prompts.Get
  alias Auth0.Management.Prompts.Patch
  alias Auth0.Management.Prompts.CustomText

  @type prompt :: String.t()
  @type language :: String.t()
  @type config :: Config.t()
  @type response_body :: String.t()
  @type error :: {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/prompts"
  @endpoint_custom_text "/api/v2/prompts/{prompt}/custom-text/{language}"

  @doc """
  Get prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_prompts

  """
  @spec get(config) :: {:ok, Entity.Prompt.t(), response_body} | error
  def get(%Config{} = config) do
    Get.execute(@endpoint, config)
  end

  @doc """
  Update prompts settings.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/patch_prompts

  """
  @spec update(Patch.Params.t() | map, config) ::
          {:ok, Entity.Prompt.t(), response_body} | error
  def update(%{} = params, %Config{} = config) do
    Patch.execute(@endpoint, params, config)
  end

  @doc """
  Get custom text for a prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/get_custom_text_by_language

  """
  @spec get_custom_text(prompt, language, config) ::
          {:ok, Entity.CustomText.t(), response_body} | error
  def get_custom_text(prompt, language, %Config{} = config) do
    CustomText.Get.execute(@endpoint_custom_text, prompt, language, config)
  end

  @doc """
  Set custom text for a specific prompt.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Prompts/put_custom_text_by_language

  """
  @spec set_custom_text(prompt, language, CustomText.Put.Params.t() | map, config) ::
          {:ok, Entity.CustomText.t(), response_body} | error
  def set_custom_text(prompt, language, %{} = params, %Config{} = config) do
    CustomText.Put.execute(@endpoint_custom_text, prompt, language, params, config)
  end
end
