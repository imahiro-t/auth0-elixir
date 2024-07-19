defmodule Auth0.Management.Tickets.EmailVerification.Create do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http

  defmodule Params do
    @moduledoc false
    defmodule Identity do
      @moduledoc false
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
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: list() | map()
  @type response :: {:ok, entity} | {:error, integer, term} | {:error, term}

  @doc """
  Create an email verification ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Tickets/post_email_verification

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
      {:ok, 201, body} -> {:ok, body |> Jason.decode!()}
      error -> error
    end
  end
end
