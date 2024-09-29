# Auth0Api

Management API for Auth0

## Installation

The package can be installed by adding `auth0_api` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:auth0_api, "~> 2.2.0"}
  ]
end
```

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

## Release Notes

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
