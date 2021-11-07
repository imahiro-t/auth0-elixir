defmodule Auth0.Management.Tickets.EmailVerification.Create do
  @moduledoc """
  Documentation for Auth0 Management Create an email verification ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_email_verification
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.Ticket

  defmodule Params do
    defmodule Identity do
      defstruct user_id: nil,
                provider: nil

      @type t :: %__MODULE__{
              user_id: String.t(),
              provider: String.t()
            }
    end

    defstruct result_url: nil,
              user_id: nil,
              client_id: nil,
              organization_id: nil,
              ttl_sec: nil,
              includeEmailInRedirect: nil,
              identity: nil

    @type t :: %__MODULE__{
            result_url: String.t(),
            user_id: String.t(),
            client_id: String.t(),
            organization_id: String.t(),
            ttl_sec: integer,
            includeEmailInRedirect: boolean,
            identity: Identity
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: Ticket.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create an email verification ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_email_verification

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> Http.post(body, config)
    |> case do
      {:ok, 201, body} -> {:ok, Ticket.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
