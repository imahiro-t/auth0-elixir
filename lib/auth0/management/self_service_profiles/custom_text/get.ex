defmodule Auth0.Management.SelfServiceProfiles.CustomText.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type language :: String.t()
  @type page :: String.t()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/self-service-profiles/{id}/custom-text/{language}/{page}"

  @doc """
  Get custom text for a self-service profile.

  Retrieves text customizations for a given self-service profile, language and Self-Service Enterprise Configuration flow page.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/get-self-service-profile-custom-text

  """
  @spec execute(id, language, page, config) :: response
  def execute(id, language, page, %Config{} = config) do
    path(id, language, page)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end

  defp path(id, language, page) do
    @endpoint
    |> String.replace("{id}", Util.encode_path_param(id))
    |> String.replace("{language}", Util.encode_path_param(language))
    |> String.replace("{page}", Util.encode_path_param(page))
  end
end
