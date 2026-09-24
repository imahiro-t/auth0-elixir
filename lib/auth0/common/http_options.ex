defmodule Auth0.Common.HttpOptions do
  @moduledoc false

  # HTTPoison options passed on every request made by this library (Management API and
  # Authentication API, including the token requests made by the token cache).
  #
  # - Timeouts: hackney 4 has no receive timeout by default (a pooled connection is started
  #   with `recv_timeout: infinity` unless the caller passes one), so a server that accepts
  #   the connection but never responds would block the caller forever. Both timeouts are
  #   always passed explicitly; see `Auth0.Config.get_recv_timeout/1` and
  #   `Auth0.Config.get_connect_timeout/1` for the defaults (5000 / 8000 ms, the same values
  #   hackney 1.x used).
  # - Pool: hackney 4's pool opens new connections (DNS resolution + TCP connect) inside the
  #   pool process, synchronously, so while one connection attempt is slow every checkout
  #   from the same pool waits (up to connect_timeout, then `:checkout_timeout`), whatever
  #   host it is for. Using hackney's shared `:default` pool would let a slow/unreachable
  #   Auth0 domain stall every other hackney user in the host application, and vice versa.
  #   Each Auth0 domain therefore gets its own pool, named `{:auth0_api, domain}`, so a slow
  #   domain only delays requests to that same domain. The pools are started lazily by
  #   hackney (under hackney's own supervisor) on the first request to a domain, and live
  #   as long as hackney runs; there is one per distinct domain used.

  alias Auth0.Config

  @type config :: Config.t()

  @spec build(config) :: keyword
  def build(%Config{} = config) do
    [
      recv_timeout: Config.get_recv_timeout(config),
      timeout: Config.get_connect_timeout(config),
      hackney: [pool: pool_name(config)]
    ]
  end

  @spec pool_name(config) :: {:auth0_api, String.t() | nil}
  def pool_name(%Config{} = config), do: {:auth0_api, Config.get_domain(config)}
end
