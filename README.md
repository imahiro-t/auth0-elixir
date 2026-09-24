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
    {:auth0_api, "~> 2.5"}
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

### Query parameters with multiple values

For query parameters that the API defines as arrays, pass a list. The key is sent once per value (`strategy=auth0&strategy=google-oauth2`):

```elixir
Auth0.Api.Management.get_connections(%{strategy: ["auth0", "google-oauth2"]}, config)
```

`nil` values in the list are skipped. Scalar values are sent as before.

### Path parameters

The functions for the endpoints newly supported in 2.5.0 percent-encode path parameters, so pass IDs as they are (for example `"auth0|123"`, sent as `auth0%7C123`). Their `@doc` says "Path parameters are percent-encoded".

All other functions insert path parameters as given, without encoding, so that existing callers who already encode IDs keep working. This includes the functions that existed before 2.5.0 and the 5 functions added in 2.5.0 for endpoints the library already supported internally (`get_prompt_rendering`, `update_prompt_rendering`, `update_session`, and the Bot Detection functions). For those functions, encode an ID yourself if it can contain characters such as `|`, `/`, `?` or `#`. Encoding them all consistently is planned for the next major version.

### Custom domain header

Functions whose endpoints accept the `auth0-custom-domain` header take an optional `opts` keyword list as their last argument. Auth0 then uses that custom domain for the links it generates (for example in verification emails and tickets):

```elixir
Auth0.Api.Management.create_password_change_ticket(params, config, custom_domain: "login.example.com")
```

Supported by `create_user`, `update_user`, `create_email_verification_ticket`, `create_password_change_ticket`, `send_job_verification_email`, `create_organization_invitation`, `create_guardian_enrollment_ticket`, `create_self_service_profile_sso_ticket` and `test_branding_phone_template`. Only a host name, optionally with a port, is accepted; any other value (including one containing CR/LF) raises `ArgumentError`. Without the option, no header is sent.


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

## Supported endpoints

The library follows the official Auth0 Management API v2 OpenAPI specification as of 2026-09-24. The differences between that specification and 2.4.0, and how each one was handled in 2.5.0 (including the endpoints intentionally not supported, such as beta endpoints), are listed in [`docs/management_api_diff.md`](docs/management_api_diff.md) (Japanese). Functions for Early Access endpoints say so in their `@doc`.

## Deprecations

The following functions of `Auth0.Api.Management` are marked with `@deprecated`. They still work and will not be removed before the next major version, but calling them produces a compile-time warning. **If you compile with `--warnings-as-errors`, migrate these calls first**, or the build fails.

| Functions | Reason | Migrate to |
|---|---|---|
| `get_hooks`, `create_hook`, `get_hook`, `update_hook`, `delete_hook` | Auth0 has announced the end of life of Hooks | [Auth0 Actions](https://auth0.com/docs/customize/actions): `get_actions`, `create_action` (then `deploy_action` and `update_action_trigger_bindings`), `get_action`, `update_action`, `delete_action` |
| `get_hook_secrets`, `add_hook_secrets`, `update_hook_secrets`, `delete_hook_secrets` | Auth0 has announced the end of life of Hooks | The `secrets` of an action (`get_action`, `update_action`) |
| `get_rules`, `create_rule`, `get_rule`, `update_rule`, `delete_rule` | Auth0 has announced the end of life of Rules | [Auth0 Actions](https://auth0.com/docs/customize/actions): `get_actions`, `create_action` (then `deploy_action` and `update_action_trigger_bindings`), `get_action`, `update_action`, `delete_action` |
| `get_blacklisted_tokens`, `blacklist_token` | Removed from the Management API | No direct replacement; use purpose-specific revocation such as `revoke_refresh_tokens` or `revoke_session` |
| `create_risk_assessment`, `get_risk_assessment` | Not part of the Management API | `get_risk_assessments_settings`, `update_risk_assessments_settings`, `get_risk_assessments_new_device_settings`, `update_risk_assessments_new_device_settings`, `clear_user_risk_assessments` |
| `create_supplemental_signal`, `get_supplemental_signal` | Not part of the Management API | `get_supplemental_signals`, `update_supplemental_signals` |

Some parameters are deprecated by Auth0 while the functions are not; they are noted in the `@doc` of the functions that use them: `enabled_clients` of connections (use `get_connection_clients` / `update_connection_clients`), deprecated connection options and strategies, `oidc_backchannel_logout` of clients (use `oidc_logout`) and `include_totals` of `get_log_events`.

## Release Notes

### 2.5.0

See [CHANGELOG.md](CHANGELOG.md) for details, including the full list of new functions and fixes.

- ✨ Follow the Auth0 Management API v2 OpenAPI specification (2026-09-24): 153 new functions (148 new endpoints) in areas such as Actions modules, Agents, Groups, Rate Limit Policies, Refresh Tokens, Organizations, Connections (directory provisioning, keys, enabled clients), Guardian settings, Keys, Flows, Event Streams, Risk Assessments settings and Supplemental Signals
- ✨ Add the `:custom_domain` option (the `auth0-custom-domain` header) to the 9 functions that support it; an invalid value raises `ArgumentError`
- ✨ Support query parameters with multiple values (pass a list)
- ✨ Add query parameters to `get_custom_domain_configurations` and `get_daily_stats`
- 🔒 Percent-encode path parameters in the new functions (existing functions are unchanged)
- ⚠️ Deprecate 20 functions (Hooks, Rules, Blacklists, Risk Assessments, Supplemental Signals) with `@deprecated`; builds with `--warnings-as-errors` fail until the calls are migrated
- 🐛 `delete_organization_invitation` returns `{:ok, ""}` instead of `{:ok, 204, ""}`
- 🐛 `get_connection_status` returns `{:ok, true}` instead of raising
- 🐛 `get_active_users_count` is documented to return a string (`{:ok, "123"}`); the return value is unchanged
- 🐛 Fix the paths or methods of `update_hook_secrets`, `rekey_encryption_key`, `revoke_session` and the Verifiable Credentials functions (now verification templates), and responses without a body that raised
- 📝 Correct the 2.3.0 notes for Verifiable Credentials, Risk Assessments and Supplemental Signals
- 🔧 Add `credo` and `dialyxir` (dev/test only)

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
- ✨ Add Bot Detection Management endpoints (public functions in `Auth0.Api.Management` added in 2.5.0)
- ✨ Add Prompts Rendering & Partials endpoints (public rendering functions in `Auth0.Api.Management` added in 2.5.0)
- ✨ Add Session Update endpoint (public function in `Auth0.Api.Management` added in 2.5.0)
- ✨ Add Client Secret Rotation endpoint
- ✨ Add Connection Status endpoint
- ✨ Add Connection Profiles management endpoints
- ✨ Add Event Streams management endpoints
- ✨ Add Network ACLs management endpoints
- ✨ Add User Attribute Profiles management endpoints
- ✨ Add Token Exchange Profiles management endpoints
- ✨ Add Verifiable Credentials management endpoints (corrected in 2.5.0: these functions sent requests to a path that does not exist; they now manage verification templates)
- ✨ Add Risk Assessments management endpoints (corrected in 2.5.0: these endpoints do not exist in the Management API, so the functions are deprecated; the risk assessment settings endpoints are added in 2.5.0)
- ✨ Add Supplemental Signals management endpoints (corrected in 2.5.0: these endpoints do not exist in the Management API, so the functions are deprecated; the supplemental signals configuration endpoints are added in 2.5.0)
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
