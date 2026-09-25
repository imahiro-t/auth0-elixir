defmodule Auth0.Management.SelfServiceProfiles.CustomText.Put do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type id :: String.t()
  @type language :: String.t()
  @type page :: String.t()
  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/self-service-profiles/{id}/custom-text/{language}/{page}"

  @doc """
  Set custom text for a self-service profile.

  Updates text customizations for a given self-service profile, language and Self-Service Enterprise Configuration flow page.

  ## see
  https://auth0.com/docs/api/management/v2/self-service-profiles/put-self-service-profile-custom-text

  """
  @spec execute(id, language, page, params, config) :: response
  def execute(id, language, page, %{} = params, %Config{} = config) do
    Util.build_path(@endpoint, id: id, language: language, page: page)
    |> Http.put(params, config)
    |> case do
      {:ok, 200, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
