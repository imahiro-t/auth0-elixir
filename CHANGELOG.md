# Changelog

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
