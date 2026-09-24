defmodule Auth0.Common.Management.TokenManager do
  @moduledoc false

  # Caches Management API access tokens obtained with the client credentials flow.
  #
  # - Cache key is `{domain, client_id, sha256(client_secret)}`:
  #   - the domain keeps the same client_id used against different tenants from sharing a
  #     token;
  #   - the client_secret digest makes a cache hit require the same credentials that obtained
  #     the token, so a Config with a known domain/client_id (neither is secret) but a wrong
  #     client_secret can never be served another caller's cached Management API token.
  #   Only the SHA-256 digest is used, never the plain secret, because the `:protected` ETS
  #   table is readable by any process.
  # - A token is stored with an "early" expiration: `now + expires_in - margin` where
  #   `margin = min(30, div(expires_in, 2))`, and it is treated as expired when
  #   `now >= expiration`. A token with `expires_in: 0` is therefore never reused (it is
  #   fetched on every call); with `expires_in: 1` the margin is 0, so it may be reused within
  #   the same second.
  # - The ETS table is owned by `Store` (a GenServer started under `Auth0.Application`), is
  #   `:protected`, and is written only through `GenServer.call/2` to the Store. Reads go
  #   directly to ETS from the caller.
  # - When the application (and thus the Store) is not running, caching is silently skipped
  #   and a token is requested on every call, as with `token_cache_disabled: true`.

  defmodule Store do
    @moduledoc false
    use GenServer

    @registry :tokens_registry
    @type key :: {String.t() | nil, String.t() | nil, binary | nil}
    @type token :: String.t()
    @type expiration :: integer

    @spec start_link(term) :: GenServer.on_start()
    def start_link(_opts \\ []) do
      GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    end

    @spec get(key) :: {token, expiration} | nil
    def get(key) do
      if :ets.whereis(@registry) == :undefined do
        nil
      else
        case :ets.lookup(@registry, key) do
          [] -> nil
          [{_key, value}] -> value
        end
      end
    rescue
      # The table can disappear between the whereis check and the lookup
      # (Store crashed or the application is stopping). Behave as a cache miss.
      ArgumentError -> nil
    end

    @spec put(key, {token, expiration}) :: :ok
    def put(key, value), do: call({:put, key, value})

    @spec delete(key) :: :ok
    def delete(key), do: call({:delete, key})

    @doc false
    @spec clear() :: :ok
    def clear(), do: call(:clear)

    defp call(message) do
      if Process.whereis(__MODULE__) |> is_nil() do
        :ok
      else
        try do
          GenServer.call(__MODULE__, message)
        catch
          :exit, _ -> :ok
        end
      end
    end

    @impl true
    def init(nil) do
      _ = :ets.new(@registry, [:set, :protected, :named_table, read_concurrency: true])
      {:ok, nil}
    end

    @impl true
    def handle_call({:put, key, value}, _from, state) do
      _ = :ets.insert(@registry, {key, value})
      {:reply, :ok, state}
    end

    def handle_call({:delete, key}, _from, state) do
      _ = :ets.delete(@registry, key)
      {:reply, :ok, state}
    end

    def handle_call(:clear, _from, state) do
      _ = :ets.delete_all_objects(@registry)
      {:reply, :ok, state}
    end
  end

  alias Auth0.Config
  alias Auth0.Authentication
  alias Auth0.Entity.Token
  alias Auth0.Authentication.Token.ClientCredentials

  @type config :: Config.t()

  @spec get_token(config) :: String.t() | nil
  def get_token(%Config{token_cache_disabled: true} = config) do
    case config |> request_token() do
      %Token{access_token: access_token} -> access_token
      _ -> nil
    end
  end

  def get_token(%Config{clear_token_cache: clear_token_cache} = config) do
    key = config |> cache_key()

    _ = if clear_token_cache, do: key |> Store.delete()

    token =
      case key |> Store.get() do
        {token, expiration_time_second} ->
          if expired?(system_time_second(), expiration_time_second) do
            nil
          else
            token
          end

        _ ->
          nil
      end

    if token |> is_nil do
      case config |> request_token() do
        %Token{access_token: access_token, expires_in: expires_in} ->
          key |> Store.put({access_token, expiration_time_second(expires_in)})
          access_token

        _ ->
          nil
      end
    else
      token
    end
  end

  defp cache_key(%Config{} = config) do
    {Config.get_domain(config), Config.get_client_id(config),
     secret_digest(Config.get_client_secret(config))}
  end

  defp secret_digest(secret) when is_binary(secret), do: :crypto.hash(:sha256, secret)
  defp secret_digest(_secret), do: nil

  defp system_time_second(), do: System.system_time(:second)

  defp expiration_time_second(expires_in) when is_integer(expires_in) and expires_in > 0 do
    margin = min(30, div(expires_in, 2))
    system_time_second() + expires_in - margin
  end

  # Missing / non-positive / non-integer expires_in: treat as already expired.
  defp expiration_time_second(_expires_in), do: system_time_second()

  defp expired?(system_time_second, expiration_time_second) do
    system_time_second >= expiration_time_second
  end

  defp request_token(config) do
    %ClientCredentials.Params{
      audience: config |> get_audience(),
      client_id: config |> Config.get_client_id(),
      client_secret: config |> Config.get_client_secret()
    }
    |> Authentication.token_by_client_credentials(config)
    |> case do
      {:ok, %Token{access_token: access_token} = token}
      when access_token |> is_binary ->
        token

      _ ->
        nil
    end
  end

  defp get_audience(%Config{} = config), do: "https://#{Config.get_domain(config)}/api/v2/"
end
