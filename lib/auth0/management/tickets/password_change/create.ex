defmodule Auth0.Management.Tickets.PasswordChange.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  @type params :: map()
  @type config :: Config.t()
  @type entity :: map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @endpoint "/api/v2/tickets/password-change"

  @doc """
  Create a password change ticket for a given user. A password change ticket is a generated URL that the user can consume to start a reset password flow.

  ## see
  https://auth0.com/docs/api/management/v2/tickets/post-password-change

  """
  @spec execute(params, config) :: response
  def execute(%{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    @endpoint
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
