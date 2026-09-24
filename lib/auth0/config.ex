defmodule Auth0.Config do
  alias Auth0.Config

  @moduledoc """
  Documentation for Auth0 Configuration.

  ## properties

  - :domain - Auth0 domain
  - :api_token - API token
  - :client_id - Client ID. This value is ignored when API token is provided.
  - :client_secret - Client Secret. This value is ignored when API token is provided.
  - :max_request_retry_count - Max retry count of request when rate limit is exceeded.
  - :correlation_id - Correlation ID
  - :token_cache_disabled - disable token cache
  - :clear_token_cache - clear token cache
  - :http_protocol - `"https"` (default) or `"http"`. `nil` is treated as `"https"` and any
    other value raises `ArgumentError`. `"http"` is intended only for tests and local mock
    servers: credentials (API token, client secret, access token) are sent in plain text.
    When `"http"` is used with a domain whose host is not a loopback address
    (`localhost`, `127.0.0.0/8`, `::1`), a warning is logged once per domain.
    The setting applies to both Management API and Authentication API requests.
  - :recv_timeout - Timeout in milliseconds for receiving the response once the request has
    been sent. Defaults to `5000` (`nil` is treated as the default). Must be a positive
    integer; any other value raises `ArgumentError`. A request whose response does not arrive
    in time returns `{:error, :timeout}`.
  - :connect_timeout - Timeout in milliseconds for establishing a connection (name
    resolution and TCP connect). Defaults to `8000` (`nil` is treated as the default). Must be
    a positive integer; any other value raises `ArgumentError`.
    Both timeouts apply to Management API and Authentication API requests (including the
    token requests made by the token cache).

  ## available environment

  - AUTH0_DOMAIN - This value is used when `%Config{domain: nil}`.
  - AUTH0_API_TOKEN - This value is used when `%Config{api_token: nil}`.
  - AUTH0_CLIENT_ID - This value is used when `%Config{client_id: nil}`.
  - AUTH0_CLIENT_SECRET - This value is used when `%Config{client_secret: nil}`.
  - AUTH0_MAX_REQUEST_RETRY_COUNT - This value is used when `%Config{max_request_retry_count: nil}`.

  ## sensitive values

  `:api_token` and `:client_secret` are excluded from `inspect/2` output (and therefore from
  logs and crash reports that inspect the struct). This does not apply to
  `inspect(config, structs: false)` or to maps built with `Map.from_struct/1`.
  """

  require Logger

  @derive {Inspect, except: [:api_token, :client_secret]}
  defstruct domain: nil,
            api_token: nil,
            client_id: nil,
            client_secret: nil,
            max_request_retry_count: nil,
            correlation_id: nil,
            token_cache_disabled: false,
            clear_token_cache: false,
            http_protocol: "https",
            recv_timeout: nil,
            connect_timeout: nil

  @type t :: %__MODULE__{
          domain: String.t(),
          api_token: String.t(),
          client_id: String.t(),
          client_secret: String.t(),
          max_request_retry_count: integer,
          correlation_id: String.t(),
          token_cache_disabled: boolean,
          clear_token_cache: boolean,
          http_protocol: String.t(),
          recv_timeout: pos_integer | nil,
          connect_timeout: pos_integer | nil
        }

  @type config :: Config.t()

  @max_request_default_retry_count 3
  @default_recv_timeout 5_000
  @default_connect_timeout 8_000

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

  Only `"https"` and `"http"` are accepted (`nil` is treated as `"https"`); any other value
  raises `ArgumentError`. When `"http"` is used with a non-loopback domain, a warning is
  logged once per domain in the VM.
  """
  @spec get_http_protocol(config) :: String.t()
  def get_http_protocol(%Config{http_protocol: nil}), do: "https"
  def get_http_protocol(%Config{http_protocol: "https"}), do: "https"

  def get_http_protocol(%Config{http_protocol: "http"} = config) do
    domain = get_domain(config)
    _ = if not loopback?(domain), do: warn_insecure_http_once(domain)
    "http"
  end

  def get_http_protocol(%Config{http_protocol: http_protocol}) do
    raise ArgumentError,
          "invalid :http_protocol #{inspect(http_protocol)}, expected \"https\" or \"http\""
  end

  @doc """
  get receive timeout (milliseconds). defaults to 5000.

  Raises `ArgumentError` unless the value is `nil` or a positive integer.
  """
  @spec get_recv_timeout(config) :: pos_integer
  def get_recv_timeout(%Config{recv_timeout: recv_timeout}),
    do: timeout_value(:recv_timeout, recv_timeout, @default_recv_timeout)

  @doc """
  get connect timeout (milliseconds). defaults to 8000.

  Raises `ArgumentError` unless the value is `nil` or a positive integer.
  """
  @spec get_connect_timeout(config) :: pos_integer
  def get_connect_timeout(%Config{connect_timeout: connect_timeout}),
    do: timeout_value(:connect_timeout, connect_timeout, @default_connect_timeout)

  defp timeout_value(_key, nil, default), do: default
  defp timeout_value(_key, value, _default) when is_integer(value) and value > 0, do: value

  defp timeout_value(key, value, _default) do
    raise ArgumentError,
          "invalid #{inspect(key)} #{inspect(value)}, expected a positive integer (milliseconds)"
  end

  defp loopback?(domain) when is_binary(domain) do
    case URI.parse("http://" <> domain).host do
      nil ->
        false

      host ->
        String.downcase(host) == "localhost" or
          case :inet.parse_address(String.to_charlist(host)) do
            {:ok, {127, _, _, _}} -> true
            {:ok, {0, 0, 0, 0, 0, 0, 0, 1}} -> true
            _ -> false
          end
    end
  end

  defp loopback?(_domain), do: false

  defp warn_insecure_http_once(domain) do
    key = {__MODULE__, :insecure_http_warned, domain}

    if :persistent_term.get(key, false) do
      :ok
    else
      Logger.warning(
        "auth0_api: http_protocol \"http\" is used for non-loopback domain " <>
          "#{inspect(domain)}; credentials are sent in plain text. " <>
          "Use \"http\" only for tests or local mock servers."
      )

      :persistent_term.put(key, true)
    end
  end
end
