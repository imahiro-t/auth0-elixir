defmodule Auth0.Management.Emails.Provider.Configure do
  @moduledoc """
  Documentation for Auth0 Management Configure the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/post_provider
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.EmailProvider

  defmodule Params do
    defstruct name: nil,
              enabled: nil,
              default_from_address: nil,
              credentials: nil,
              settings: nil

    @type t :: %__MODULE__{
            name: String.t(),
            enabled: boolean,
            default_from_address: String.t(),
            credentials: map,
            settings: map
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: EmailProvider.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Configure the email provider.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Emails/post_provider

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, EmailProvider.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
