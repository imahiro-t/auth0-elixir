defmodule Auth0.Config do
  alias Auth0.Config

  @moduledoc """
  Documentation for Auth0 Configuration.

  ## properties

  - :domain - Auth0 domain
  - :api_token - API token
  - :client_id - Client ID. This value is ignored when API token is provided.
  - :client_secret - Client Secret. This value is ignored when API token is3 provided.
  - :max_request_retry_count - Max retry count of request when rate limit is exceeded.
  - :correlation_id - Correlation ID
  - :token_cache_disabled - disable token cache
  - :clear_token_cache - clear token cache

  ## available environment

  - AUTH0_DOMAIN - This value is used when `%Config{domain: nil}`.
  - AUTH0_API_TOKEN - This value is used when `%Config{api_token: nil}`.
  - AUTH0_CLIENT_ID - This value is used when `%Config{client_id: nil}`.
  - AUTH0_CLIENT_SECRET - This value is used when `%Config{client_secret: nil}`.
  - AUTH0_MAX_REQUEST_RETRY_COUNT - This value is used when `%Config{max_request_retry_count: nil}`.
  """

  defstruct domain: nil,
            api_token: nil,
            client_id: nil,
            client_secret: nil,
            max_request_retry_count: nil,
            correlation_id: nil,
            token_cache_disabled: false,
            clear_token_cache: false,
            http_protocol: "https"

  @type t :: %__MODULE__{
          domain: String.t() | nil,
          api_token: String.t() | nil,
          client_id: String.t() | nil,
          client_secret: String.t() | nil,
          max_request_retry_count: integer | nil,
          correlation_id: String.t() | nil,
          token_cache_disabled: boolean,
          clear_token_cache: boolean,
          http_protocol: String.t()
        }

  @type config :: Config.t()

  @max_request_default_retry_count 3

  @doc """
  get Auth0 domain.

  """
  @spec get_domain(config) :: String.t() | nil
  def get_domain(%Config{domain: nil}), do: System.get_env("AUTH0_DOMAIN")
  def get_domain(%Config{domain: domain}), do: domain

  @doc """
  get API token.

  """
  @spec get_api_token(config) :: String.t() | nil
  def get_api_token(%Config{api_token: nil}), do: System.get_env("AUTH0_API_TOKEN")
  def get_api_token(%Config{api_token: api_token}), do: api_token

  @doc """
  get Client ID..

  """
  @spec get_client_id(config) :: String.t() | nil
  def get_client_id(%Config{client_id: nil}), do: System.get_env("AUTH0_CLIENT_ID")
  def get_client_id(%Config{client_id: client_id}), do: client_id

  @doc """
  get Client Secret.

  """
  @spec get_client_secret(config) :: String.t() | nil
  def get_client_secret(%Config{client_secret: nil}), do: System.get_env("AUTH0_CLIENT_SECRET")
  def get_client_secret(%Config{client_secret: client_secret}), do: client_secret

  @doc """
  get max retry count of request.

  """
  @spec get_max_request_retry_count(config) :: integer
  def get_max_request_retry_count(%Config{max_request_retry_count: nil}),
    do:
      System.get_env(
        "AUTH0_MAX_REQUEST_RETRY_COUNT",
        @max_request_default_retry_count |> to_string
      )
      |> String.to_integer()

  def get_max_request_retry_count(%Config{max_request_retry_count: max_request_retry_count}),
    do: max_request_retry_count

  @doc """
  get HTTP Protocol. defaults to "https".
  """
  @spec get_http_protocol(config) :: String.t()
  def get_http_protocol(%Config{http_protocol: nil}), do: "https"
  def get_http_protocol(%Config{http_protocol: http_protocol}), do: http_protocol
end
