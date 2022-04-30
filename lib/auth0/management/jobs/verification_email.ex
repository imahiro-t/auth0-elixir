defmodule Auth0.Management.Jobs.VerificationEmail do
  @moduledoc """
  Documentation for Auth0 Management Send an email address verification email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_verification_email
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.JobsVerificationEmail

  defmodule Params do
    defmodule Identity do
      defstruct user_id: nil,
                provider: nil

      @type t :: %__MODULE__{
              user_id: String.t(),
              provider: String.t()
            }
    end

    defstruct user_id: nil,
              client_id: nil,
              identity: nil,
              organization_id: nil

    @type t :: %__MODULE__{
            user_id: String.t(),
            client_id: String.t(),
            identity: Identity.t(),
            organization_id: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map
  @type config :: Config.t()
  @type entity :: JobsVerificationEmail.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Send an email address verification email.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/post_verification_email

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 201, body} ->
        {:ok, JobsVerificationEmail.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
