# Auth0Api

Management API for Auth0

## Installation

The package can be installed by adding `auth0_api` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:auth0_api, "~> 1.2.0"}
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

### simple version

```elixir
params = %{
  include_totals: true
}
Auth0.Simple.Management.get_users(params, config)
```

### structured version

```elixir
params = %Auth0.Management.Users.List.Params{
  include_totals: true
}
Auth0.Management.get_users(params, config)
# or
Auth0.Management.Users.list(params, config)
```

The docs can be found at [https://hexdocs.pm/auth0_api](https://hexdocs.pm/auth0_api).
