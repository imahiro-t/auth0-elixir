# Auth0Api

Management API for Auth0

## Installation

The package can be installed by adding `auth0_api` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:auth0_api, "~> 2.1.0"}
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

The docs can be found at [https://hexdocs.pm/auth0_api](https://hexdocs.pm/auth0_api).
