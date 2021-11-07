defmodule Auth0.Management.Guardian.Sms.Template.Put do
  @moduledoc """
  Documentation for Auth0 Management Update SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_templates_0
  """

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.GuardianSmsTemplate

  defmodule Params do
    defstruct enrollment_message: nil,
              verification_message: nil

    @type t :: %__MODULE__{
            enrollment_message: String.t(),
            verification_message: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t()
  @type config :: Config.t()
  @type entity :: GuardianSmsTemplate.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Update SMS Enrollment and Verification Templates.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Guardian/put_templates_0

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    body = params |> Util.to_map() |> Util.remove_nil()

    endpoint
    |> Http.put(body, config)
    |> case do
      {:ok, 200, body} -> {:ok, GuardianSmsTemplate.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
