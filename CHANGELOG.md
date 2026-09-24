# Changelog

## 2.5.0

This release brings the library up to date with the official Auth0 Management API v2 OpenAPI specification (fetched 2026-09-24). It adds the missing endpoints and parameters, fixes functions that did not match the specification, and deprecates functions whose endpoints were removed or reached end of life. No public function or arity is removed. The requirements are unchanged from 2.4.0 (Elixir 1.17+, Erlang/OTP 27+).

The full list of differences between the specification and 2.4.0 (added / changed / deprecated, with the function name for each item and the reason for every item that is not covered) is in [`docs/management_api_diff.md`](docs/management_api_diff.md) (Japanese). It is included in the ExDoc documentation but not in the Hex package.

A few return values change as bug fixes (see "Fixed"). Calling a deprecated function now emits a compile-time warning, so read "Deprecated" if you compile with `--warnings-as-errors`.

### Added

- ✨ 153 new functions in `Auth0.Api.Management`: 148 for endpoints that were not supported, and 5 that expose endpoints that 2.4.0 only had internally (`get_attack_protection_bot_detection`, `update_attack_protection_bot_detection`, `get_prompt_rendering`, `update_prompt_rendering`, `update_session`). By area:
  - **Actions**: action modules (list, create, get, update, delete, the actions using a module, rollback, versions) — `get_action_modules`, `create_action_module`, …
  - **Agents** (new facade `Auth0.Management.Agents`): list, create, get, update, delete
  - **Attack Protection**: CAPTCHA and phone provider protection settings (get / update)
  - **Client Grants**: get a client grant, list its organizations
  - **Clients**: CIMD metadata preview and client registration, list the connections of a client
  - **Connection Profiles**: create, delete, templates (list / get)
  - **Connections**: enabled clients (`get_connection_clients`, `update_connection_clients`), directory provisioning (configuration, default mapping, synchronizations, synchronized groups), connection keys (list / create / rotate), tenant-wide listings of directory provisionings and SCIM configurations
  - **Custom Domains**: default custom domain (get / set), test a custom domain
  - **Emails**: delete the email provider
  - **Event Streams**: deliveries (list / get), redelivery, test event
  - **Flows / Forms**: Flows vault connections (CRUD), flow executions (list / get / delete), delete a flow, delete a form
  - **Groups** (new facade `Auth0.Management.Groups`): list, get, delete, members, roles (list / assign / remove)
  - **Guardian**: Duo, email and phone factor settings, Guardian settings
  - **Keys**: custom signing keys (get / set / delete), Network ACL keys (list / create / get / delete)
  - **Network ACLs**: replace a Network ACL (`set_network_acl`)
  - **Organizations**: search, client grants, clients, associated connections (`/organizations/{id}/connections`; named `*_organization_associated_connection*` to keep them apart from the existing `*_organization_connection*` functions for enabled connections), discovery domains, members' effective roles, role members, groups and their roles
  - **Prompts**: rendering settings for all screens (list / bulk update)
  - **Rate Limit Policies** (new facade `Auth0.Management.RateLimitPolicies`): list, create, get, update, delete
  - **Refresh Tokens**: list, update, revoke (`revoke_refresh_tokens`)
  - **Resource Servers**: search
  - **Risk Assessments**: settings and new-device settings (get / update), clear a user's risk assessments (`clear_user_risk_assessments`)
  - **Roles**: groups (list / assign / remove)
  - **Self-Service Profiles**: custom text (get / set), revoke an SSO ticket
  - **Supplemental Signals**: configuration (get / update)
  - **User Attribute Profiles**: templates (list / get)
  - **Users**: connected accounts, effective permissions and roles (and their sources), groups
- ✨ 44 of the new functions are for Early Access endpoints; their `@doc` says so. The Experimentation endpoints (beta, apart from one Early Access endpoint that depends on them), `GET /clients/search` (beta), the server-sent events endpoint `GET /events`, and the deprecated or superseded Guardian SMS endpoints are not added (see the diff list for the reasons).
- ✨ `:custom_domain` option for the 9 functions whose endpoints accept the `auth0-custom-domain` header: `create_user`, `update_user`, `create_email_verification_ticket`, `create_password_change_ticket`, `send_job_verification_email`, `create_organization_invitation`, `create_guardian_enrollment_ticket`, `create_self_service_profile_sso_ticket` and `test_branding_phone_template`. Pass it as a new last argument, e.g. `create_user(params, config, custom_domain: "login.example.com")`. The existing arities are unchanged and send no header. Only a host name, optionally with a port, is accepted; any other value (including one containing CR/LF) raises `ArgumentError`, so the option cannot be used to inject headers.
- ✨ Query parameters with multiple values: passing a list as a query value sends the key once per value (`strategy=a&strategy=b`), as the specification defines for array parameters (for example `strategy` of `get_connections`, `hydrate` of `get_flows` / `get_flow` / `get_forms` / `get_form`, `identifiers` of `get_resource_servers`). Before, a list raised `ArgumentError`; scalar values are sent exactly as before, and `nil` values in a list are skipped.
- ✨ `get_custom_domain_configurations` and `get_daily_stats` accept query parameters (`get_custom_domain_configurations(params, config)`, `get_daily_stats(%{from: ..., to: ...}, config)`). Calls that pass only a config behave as before.
- 📝 The `@doc` of existing functions lists their query parameters (marking required, array and Early Access ones), and notes Early Access / beta / deprecated body properties.
- ✨ Two public helpers in `Auth0.Common.Util` for building request paths:
  - `encode_path_param/1` percent-encodes a path parameter value (every character except `A-Z a-z 0-9 - . _ ~`; a value of `.` or `..` is encoded too), e.g. `encode_path_param("auth0|123")` returns `"auth0%7C123"`.
  - `build_path/2` builds a request path from an endpoint template and a keyword list of path parameters, encoding each value with `encode_path_param/1`, e.g. `build_path("/api/v2/users/{id}", id: "auth0|123")` returns `"/api/v2/users/auth0%7C123"`.
  - The functions for the newly supported endpoints build their paths with them (see "Path parameters").
- 🔧 Add `credo` and `dialyxir` as dev/test dependencies and fix their findings in the existing code (`mix credo` and `mix dialyzer` report no issues). They are not runtime dependencies.

### Path parameters

- 🔒 The 148 functions for the newly supported endpoints percent-encode path parameters (every character except `A-Z a-z 0-9 - . _ ~`; a value of `.` or `..` is encoded too), so an ID such as `auth0|123` is sent as `auth0%7C123` and a value can never change the requested path. Pass IDs as they are, without encoding them.
- All other functions (the functions that existed before 2.5.0, including the ones fixed in this release, and the 5 new functions above for endpoints that were already supported internally) still insert path parameters as given, without encoding, so that callers who already pass encoded IDs keep working. If an ID can contain characters such as `|`, `/`, `?` or `#`, encode it yourself for these functions. Encoding them all consistently is planned for the next major version.

### Deprecated

- ⚠️ 20 functions of `Auth0.Api.Management` are marked with `@deprecated`, and their `@doc` names the replacement. They still work and are not removed in 2.x.
  - **Hooks** (end of life announced by Auth0; migrate to Actions): `get_hooks` → `get_actions`, `create_hook` → `create_action` (then `deploy_action` and `update_action_trigger_bindings`), `get_hook` → `get_action`, `update_hook` → `update_action`, `delete_hook` → `delete_action`, `get_hook_secrets` / `add_hook_secrets` / `update_hook_secrets` / `delete_hook_secrets` → the `secrets` of an action (`get_action` / `update_action`)
  - **Rules** (end of life announced by Auth0; migrate to Actions): `get_rules` → `get_actions`, `create_rule` → `create_action` (then `deploy_action` and `update_action_trigger_bindings`), `get_rule` → `get_action`, `update_rule` → `update_action`, `delete_rule` → `delete_action`
  - **Blacklists** (removed from the Management API): `get_blacklisted_tokens`, `blacklist_token`. There is no direct replacement; revoke credentials with the purpose-specific functions such as `revoke_refresh_tokens` or `revoke_session`.
  - **Risk Assessments** (these endpoints do not exist in the Management API): `create_risk_assessment` → `get_risk_assessments_settings` / `update_risk_assessments_settings`, the new-device settings functions and `clear_user_risk_assessments`; `get_risk_assessment` → `get_risk_assessments_settings` / `get_risk_assessments_new_device_settings`
  - **Supplemental Signals** (these endpoints do not exist in the Management API): `create_supplemental_signal` → `update_supplemental_signals`; `get_supplemental_signal` → `get_supplemental_signals`
- ⚠️ Calling any of these functions now produces a compile-time deprecation warning. **If you compile with `--warnings-as-errors`, your build fails until you migrate these calls** (or stop treating warnings as errors).
- ⚠️ In the facade modules, the deprecation is documented only (no `@deprecated`): in the module documentation of `Auth0.Management.Hooks`, `Auth0.Management.Rules` and `Auth0.Management.Blacklist`, and in the documentation of the affected functions of `Auth0.Management.RiskAssessments` and `Auth0.Management.SupplementalSignals`. The `@deprecated` at the top of `hooks.ex` / `rules.ex` in earlier versions only applied to `Auth0.Management.Hooks.list/2` / `Auth0.Management.Rules.list/2`, not to the whole module; it has been removed in favour of the `Auth0.Api.Management` functions above, so calling those two facade functions directly no longer warns.
- ⚠️ Deprecated parameters are noted in the `@doc` of the functions that use them (the functions themselves are not deprecated):
  - `enabled_clients` of connections (`create_connection`, `update_connection`, `get_connection`) → use `get_connection_clients` / `update_connection_clients`
  - deprecated connection `options` (Facebook, SMS, SAML `cert`) and deprecated strategies (`ip`, `instagram`, `oauth1`, `office365`, `sharepoint`, `soundcloud`, `untappd`) (`create_connection`, `update_connection`, `get_connection`, `get_connections`)
  - `oidc_backchannel_logout` of clients (`create_client`, `update_client`) → use `oidc_logout`
  - `include_totals` of `get_log_events`

### Removed

- 🔥 Remove four unused internal modules that had no documentation (`@moduledoc false`) and were never called: `Auth0.Management.Connections.Status.Check` and `Auth0.Management.Guardian.AwsSns.Configuration.{Get,Patch,Put}` (duplicates of `Auth0.Management.Guardian.Factors.PushNotification.Providers.Sns.{Get,Patch,Put}`). They were not part of the public API; `get_connection_status` and `get_guardian_aws_sns_configuration` / `patch_guardian_aws_sns_configuration` / `update_guardian_aws_sns_configuration` are unchanged.

### Fixed

- 🐛 `delete_organization_invitation` returned `{:ok, 204, ""}` on success because the success status was never matched. It now returns `{:ok, ""}`, like the other delete functions that return no body, and as its `@spec` says. **If you match on `{:ok, 204, _}`, update that code.**
- 🐛 `get_connection_status` raised on success (it decoded the empty `200` response body). It now returns `{:ok, true}` when the connection is online, as its `@spec` (`{:ok, boolean}`) promised; errors such as `404` (connection not found) are still returned as `{:error, status, body}`, not as `{:ok, false}`. The `@spec` is now `{:ok, true} | error`.
- 🐛 `get_active_users_count`: the `@spec` said `{:ok, integer}`, but the function returns the response body as a string (for example `{:ok, "123"}`). The return value is unchanged; the `@spec` and `@doc` are corrected to `{:ok, String.t()}`.
- 🐛 `update_hook_secrets` sent `PATCH /api/v2/hooks/{id}` (updating the hook itself) instead of `PATCH /api/v2/hooks/{id}/secrets`.
- 🐛 `rekey_encryption_key` sent `POST /api/v2/keys/encryption` (creating a key) instead of `POST /api/v2/keys/encryption/rekey`, and its body could not be encoded.
- 🐛 `revoke_session` used `DELETE` instead of `POST /api/v2/sessions/{id}/revoke`.
- 🐛 The Verifiable Credentials functions (`get_verifiable_credentials`, `create_verifiable_credential`, `get_verifiable_credential`, `update_verifiable_credential`, `delete_verifiable_credential`) sent requests to `/api/v2/verifiable-credentials`, which does not exist. They now use `/api/v2/verifiable-credentials/verification/templates`, i.e. they manage verification templates. The function names are kept.
- 🐛 `delete_branding_phone_provider`, `delete_branding_phone_template`, `delete_self_service_profile` and `get_job_error` raised on a `204` response (they decoded the empty body). They now return `{:ok, ""}`.
- 🐛 `add_hook_secrets`, `create_network_acl` and `update_token_exchange_profile` raised when the success response had no body. They now return `{:ok, ""}` in that case, and the decoded body as before when there is one.
- 🐛 `create_encryption_wrapping_key` always raised `Protocol.UndefinedError` because its request body could not be encoded.
- 📝 Correct the 2.3.0 entries: the "Verifiable Credentials" endpoints added in 2.3.0 did not work (see above), and the Risk Assessments and Supplemental Signals functions added in 2.3.0 call endpoints that do not exist in the Management API. They are deprecated in this release, and the endpoints that do exist are added (see "Added").
- 📝 Fix the `## see` links of the Bot Detection functions and of `update_hook_secrets`.

## 2.4.0

This release is a security-focused release. It is a minor (not patch) release because it moves to new major versions of the HTTP dependencies and raises the minimum Elixir / Erlang/OTP versions. Read "Breaking changes" before upgrading.

### Security

- 🔒 Remove a leftover `IO.inspect/1` in `Auth0.Common.Management.Http.multipart_post/3` that printed responses to standard output. No debug output remains under `lib/`.
- 🔒 Mask sensitive values in `inspect/2` output, and therefore in logs and crash reports that inspect these structs:
  - `Auth0.Config`: `:api_token`, `:client_secret`
  - `Auth0.Authentication.Token.ClientCredentials.Params`: `:client_secret`
  - `Auth0.Entity.Token`: `:access_token`, `:refresh_token`, `:id_token`
  - The fields can still be read from the struct. Masking does not apply to `inspect(value, structs: false)` or to maps built with `Map.from_struct/1`.
- 🔒 Fix the token cache so that a cached Management API token is only returned for the same tenant and credentials. The cache key was the `client_id` only; it is now `{domain, client_id, SHA-256 digest of client_secret}`.
  - The same `client_id` used against different domains (tenants) no longer shares a token.
  - A config with the right `domain` / `client_id` but a different `client_secret` no longer gets a token cached by another caller; it asks `/oauth/token` itself.
  - The plain `client_secret` is never stored in the cache (only its digest and the access token are).
- 🐛 The token cache ETS table is now owned by a supervised process started by `Auth0.Application`, and all writes go through it. Before, the table was owned by whichever process first requested a token, so the cache was lost when that process exited and other processes could not update it.
- 🔒 `http_protocol` is validated. Only `"https"` (default) and `"http"` are accepted; `"http"` is for tests and local mock servers only, because the API token, the client secret and access tokens are sent in plain text. When `"http"` is used with a non-loopback domain (anything other than `localhost`, `127.0.0.0/8` or `::1`), a warning is logged once per domain. See "HTTP protocol" in the README.
- 🔒 Fix known hackney advisories that affected 2.3.0 by moving to httpoison 3.0 / hackney 4.x. 2.3.0 depended on hackney 1.x (`~> 1.17` through httpoison 2.2), so these applied to it; all are fixed in the hackney versions 2.4.0 accepts:
  - hackney `< 4.0.1` (including 1.x): GHSA-gp9c-pm5m-5cxr (high), GHSA-j9wq-vxxc-94wf (medium), GHSA-pj7v-xfvx-wmjq (medium), GHSA-mp55-p8c9-rfw2 (low)
  - hackney 1.x: GHSA-vq52-99r9-h5pw (low, fixed in 1.21.0) and GHSA-9fm9-hp7p-53mf (low, fixed in 1.24.0)
- 🔒 Require `{:hackney, "~> 4.1"}` (now a direct dependency) so that applications cannot resolve a hackney 4.x release, or a quic release, with known advisories. These did not affect 2.3.0, which could not resolve hackney 2.x–4.x or quic; the lower bound only avoids them after the move to hackney 4:
  - hackney `>= 2.0.0, < 4.0.1` (hackney 4.0.0 is the 4.x release in this range): GHSA-76v6-f83q-pxvh (high), GHSA-9653-rcfr-5c62 (high), GHSA-q8jg-fgj4-fphf (high), GHSA-jq4m-q6p2-8gwc (high), GHSA-6cp8-v795-jr2j (high), GHSA-f9vr-g2g2-x9fg (medium); and hackney `>= 3.1.1, < 4.0.1`: GHSA-h73q-4w9q-82h4 (medium)
  - quic `<= 1.4.3`: GHSA-2r8v-p65x-3663 (critical, broken TLS verification). hackney 4.0.0 requires quic 1.0.0 and hackney 4.0.1 / 4.0.2 require quic 1.4.3, which is why the lower bound is hackney 4.1 (quic 1.4.5) rather than 4.0.1.
- 🔒 Verified that TLS server certificate verification is enabled by default with hackney 4.x (both 4.1.0 and 4.7.4): `verify_peer` with the certifi CA bundle, expiry check and hostname check. The library does not pass any `ssl` / `insecure` options. (As before, certificate revocation (CRL / OCSP) is not checked.)
- 🔒 Redirects are not followed, so a `302` from Auth0 is returned as before and credentials (the bearer token, or the client secret sent to `/oauth/token`) are not re-sent to another host.

### Breaking changes

- 💥 Dependencies move to new major versions: `{:httpoison, "~> 3.0"}` (was `~> 2.2`) and `{:hackney, "~> 4.1"}` (new direct dependency; was 1.x through httpoison). If your application depends on httpoison 2.x or hackney 1.x directly, upgrade them as well, or dependency resolution will fail.
- 💥 Elixir 1.17+ and Erlang/OTP 27+ are required (was Elixir 1.12+). `mix.exs` declares `elixir: "~> 1.17"`; OTP 27+ is required by hackney 4 and is not enforced by Mix.
- 💥 HTTPS requests use HTTP/2 by default (negotiated with ALPN; the hackney 4 default). HTTP/3 is not enabled.
- 💥 When a domain cannot be resolved (DNS failure), the error is `{:error, :checkout_timeout}` instead of `{:error, :nxdomain}`, returned after `:connect_timeout` (8 seconds by default). If you match on `:nxdomain`, update that code.
- 💥 An invalid `http_protocol` (anything other than `"https"`, `"http"` or `nil`, including `"HTTPS"`) raises `ArgumentError` instead of being used as the URL scheme.
- 💥 `http_protocol` now also applies to Authentication API requests (`/oauth/token`, including the token requests made by the token cache). Before, they always used `https`. With `"http"`, the client secret is sent in plain text.
- 💥 Invalid `recv_timeout` / `connect_timeout` values (anything other than `nil` or a positive integer, including `:infinity`) raise `ArgumentError`.
- 💥 The library now has an application callback module, `Auth0.Application`, which starts `Auth0.Supervisor` (it supervises the token cache) when `:auth0_api` starts. This is automatic for normal dependencies. If `:auth0_api` is not started (for example with `runtime: false`), requests still work, but without the token cache.

### Added

- ✨ `Auth0.Config` options `:recv_timeout` (default `5000` ms) and `:connect_timeout` (default `8000` ms). They apply to all Management API and Authentication API requests, including the token requests made by the token cache. The defaults are the same values that 2.3.0 used (the hackney 1.x defaults); `:infinity` is not accepted, use a large integer instead.

### Changed

- ⬆️ Upgrade httpoison 2.2.1 → 3.0.0 and hackney 1.20.1 → 4.7.4 (lock file).
- 🐛 Every request now passes the receive and connect timeouts explicitly. hackney 4 has no receive timeout by default, so without this a request to a server that never responds would never return.
- 🐛 Requests use a dedicated hackney connection pool per Auth0 domain, named `{:auth0_api, domain}`, instead of hackney's shared `:default` pool.
  - hackney 4 opens new connections one at a time inside a pool, so in a shared pool a slow DNS lookup or connect to one host could block requests to other hosts (including your application's own hackney requests) for up to the connect timeout. With a pool per domain, a slow tenant does not affect other tenants or your application.
  - A pool is started by hackney on the first request to a domain and stays until hackney stops, so there is one pool per domain the library has been used with. Use a fixed set of trusted domains (see "Connection pools" in the README).
  - Settings of hackney's `:default` pool (for example `:hackney_pool.set_max_connections(:default, ...)`) no longer apply to this library's requests.
- 📝 Document `:http_protocol`, `:recv_timeout` and `:connect_timeout` in `Auth0.Config`.

## 2.3.0

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

## 2.2.0

- ✨ create api for forms
- ✨ create api for flows
- ✨ create api for self service profiles
- ✨ add api for keys
- ✨ add api for users
- ✨ add api for sessions
- 📝 fix doc comment

## 2.1.0

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
