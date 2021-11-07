defmodule Auth0.Management.Guardian.Enrollments.Ticket do
  @moduledoc """
  Documentation for Auth0 Management Create a multi-factor authentication enrollment ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/post_ticket
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianEnrollmentTicket

  defmodule Params do
    defstruct user_id: nil,
              email: nil,
              send_mail: nil

    @type t :: %__MODULE__{
            user_id: String.t(),
            email: String.t(),
            send_mail: boolean
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: GuardianEnrollmentTicket.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Create a multi-factor authentication enrollment ticket.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/post_ticket

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> Http.post(body, config)
    |> case do
      {:ok, 200, body} ->
        {:ok, GuardianEnrollmentTicket.from(body |> Jason.decode!()), body}

      error ->
        error
    end
  end
end
