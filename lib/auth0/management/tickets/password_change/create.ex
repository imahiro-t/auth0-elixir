defmodule Auth0.Management.Tickets.PasswordChange.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Ticket

  defmodule Params do
    @moduledoc false
    defstruct result_url: nil,
              user_id: nil,
              client_id: nil,
              organization_id: nil,
              connection_id: nil,
              email: nil,
              ttl_sec: nil,
              mark_email_as_verified: nil,
              includeEmailInRedirect: nil

    @type t :: %__MODULE__{
            result_url: String.t(),
            user_id: String.t(),
            client_id: String.t(),
            organization_id: String.t(),
            connection_id: String.t(),
            email: String.t(),
            ttl_sec: integer,
            mark_email_as_verified: boolean,
            includeEmailInRedirect: boolean
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: Ticket.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create a password change ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_password_change

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    endpoint
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, Ticket.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
