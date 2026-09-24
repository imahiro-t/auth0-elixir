# Auth0Api

Management API for Auth0

## Requirements

- Elixir 1.17 or later
- Erlang/OTP 27 or later

These come from the HTTP client dependencies (httpoison 3.0 and hackney 4). The Elixir version is declared in `mix.exs`; the OTP version is not checked by Mix, so make sure you run on OTP 27 or later.

## Installation

The package can be installed by adding `auth0_api` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:auth0_api, "~> 2.4"}
  ]
end
```

`auth0_api` depends on `{:httpoison, "~> 3.0"}` and `{:hackney, "~> 4.1"}`. If your application depends on httpoison 2.x or hackney 1.x directly, upgrade them too.

The library starts its own supervision tree (`Auth0.Application`, which runs the token cache) when the `:auth0_api` application starts. This happens automatically for a normal dependency. If the application is not started (for example with `runtime: false`), requests still work, but tokens are not cached.

## Basic Usage

1. Set Domain, Client ID and Client Secret:

```elixir
config = %Auth0.Config{
  domain: "xxx.auth0.com",
  client_id: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  client_secret: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
# or API Token instead
config = %Auth0.Config{
  domain: "xxx.auth0.com",
  api_token: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

or You can use environment variable with keys below:

- AUTH0_DOMAIN
- AUTH0_CLIENT_ID
- AUTH0_CLIENT_SECRET
- AUTH0_API_TOKEN

Other options of `%Auth0.Config{}`:

| Option | Default | Description |
|---|---|---|
| `:http_protocol` | `"https"` | `"https"` or `"http"`. `"http"` is for tests and local mock servers only (see [HTTP protocol](#http-protocol)). Any other value raises `ArgumentError`. |
| `:recv_timeout` | `5000` | Milliseconds to wait for a response after the request is sent. A request that times out returns `{:error, :timeout}` (`raw_request/5` returns `{:error, %HTTPoison.Error{reason: :timeout}}`). |
| `:connect_timeout` | `8000` | Milliseconds to wait for a connection (DNS lookup and TCP connect). |
| `:max_request_retry_count` | `3` | Max retry count when the rate limit is exceeded. |
| `:token_cache_disabled` | `false` | Disable the token cache. |
| `:clear_token_cache` | `false` | Clear the cached token and fetch a new one. |

`:recv_timeout` and `:connect_timeout` must be positive integers (`nil` means the default; `:infinity` is not accepted). They apply to both Management API and Authentication API requests, including the token requests made by the token cache.

2. Call Management API.

### Normal Usage

```elixir
params = %{
  include_totals: true
}
Auth0.Api.Management.get_users(params, config)
```

### Raw Usage

```elixir
body = %{}
headers = %{}
Auth0.Common.Management.Http.raw_request(:get, "/api/v2/users?include_totals=true", body, headers, config)
```


## HTTP protocol

> **Warning:** `http_protocol: "http"` sends every credential in **plain text**: the API token, the **client secret** (to `/oauth/token`) and access tokens. Use it **only for tests and local mock servers**. Never use it with a real Auth0 tenant.

```elixir
# For tests against a local mock server only
config = %Auth0.Config{domain: "localhost:4000", http_protocol: "http", api_token: "test-token"}
```

- The default is `"https"`. Only `"https"` and `"http"` are accepted; any other value (including `"HTTPS"`) raises `ArgumentError`.
- The setting applies to both Management API and Authentication API requests (including the token requests made by the token cache).
- When `"http"` is used with a domain that is not a loopback address (`localhost`, `127.0.0.0/8`, `::1`), a warning is logged once per domain.

## Connection pools

Requests use a dedicated hackney connection pool for each Auth0 domain (named `{:auth0_api, domain}`), not hackney's shared `:default` pool. A slow or unreachable tenant therefore does not block requests to other tenants, or your application's own requests that use hackney's `:default` pool.

A pool is started on the first request to a domain and stays until hackney stops, so one pool exists for each domain the library has been used with. Use a fixed set of trusted domains; do not build `:domain` from untrusted input. Settings of hackney's `:default` pool do not apply to this library's requests.

## Sensitive values

`inspect/2` output of `Auth0.Config` (`:api_token`, `:client_secret`), `Auth0.Authentication.Token.ClientCredentials.Params` (`:client_secret`) and `Auth0.Entity.Token` (`:access_token`, `:refresh_token`, `:id_token`) does not include these values, so they do not appear in logs or crash reports that inspect the structs. This does not apply to `inspect(value, structs: false)` or to maps built with `Map.from_struct/1`.

## Rate Limiting

The library handles Auth0's rate limiting automatically. When a `429 Too Many Requests` response is received, it checks the `Retry-After` header and waits for the specified duration before retrying. If the header is missing, it falls back to an exponential backoff strategy.

## Deprecations

- **Rules & Hooks**: Auth0 has announced the End-of-Life for Rules and Hooks. These modules (`Auth0.Management.Rules`, `Auth0.Management.Hooks`) are now marked as deprecated. Please migrate to [Auth0 Actions](https://auth0.com/docs/customize/actions).

## Release Notes

### 2.4.0

See [CHANGELOG.md](CHANGELOG.md) for details, including breaking changes.

- 🔒 Remove debug output of responses in `multipart_post`
- 🔒 Mask the API token, client secret and tokens in `inspect/2` output
- 🔒 Include the domain and a digest of the client secret in the token cache key
- 🔒 Validate `http_protocol` and warn when `"http"` is used with a non-loopback domain
- 🔒 Fix the hackney 1.x advisories that affected 2.3.0 by moving to httpoison 3.0 / hackney 4.x
- 🔒 Require hackney ~> 4.1 to avoid the advisories of hackney 4.0.x and quic <= 1.4.3 (these did not affect 2.3.0)
- 💥 Require Elixir 1.17+ and Erlang/OTP 27+
- 💥 Use HTTP/2 by default for HTTPS; DNS failures return `:checkout_timeout` instead of `:nxdomain`
- 💥 Add `Auth0.Application` (supervises the token cache)
- ✨ Add `:recv_timeout` and `:connect_timeout` options
- 🐛 Use a dedicated connection pool per Auth0 domain (needed with hackney 4)

### 2.3.0

- ✨ Support `Retry-After` header for rate limiting
- ✨ Add Bot Detection Management endpoints
- ✨ Add Prompts Rendering & Partials endpoints
- ✨ Add Session Update endpoint
- ✨ Add Client Secret Rotation endpoint
- ✨ Add Connection Status endpoint
- ✨ Add Connection Profiles management endpoints
- ✨ Add Event Streams management endpoints
- ✨ Add Network ACLs management endpoints
- ✨ Add User Attribute Profiles management endpoints
- ✨ Add Token Exchange Profiles management endpoints
- ✨ Add Verifiable Credentials management endpoints
- ✨ Add Risk Assessments management endpoints
- ✨ Add Supplemental Signals management endpoints
- ⚠️ Deprecate Rules and Hooks APIs


### 2.2.0

- ✨ create api for forms
- ✨ create api for flows
- ✨ create api for self service profiles
- ✨ add api for keys
- ✨ add api for users
- ✨ add api for sessions
- 📝 fix doc comment

### 2.1.0

- ✨ add api for branding
- ✨ add api for connection
- ✨ add api for guardian
- ✨ add api for prompts
- ✨ add api for users
- 🐛 fix spec type
- ♻️ move guardian module path
- 🗑️ remove deprecated api
- 💥 not to use Params struct and move endpoint consistent
- 📝 mix docs for each module
- 💡 update api comment
- ⬆️ upgrade ex_doc

The docs can be found at [https://hexdocs.pm/auth0_api](https://hexdocs.pm/auth0_api).
