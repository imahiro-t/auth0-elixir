defmodule Auth0.Management.CustomDomains.Configure do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Util
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.CustomDomain

  defmodule Params do
    @moduledoc false
    defstruct domain: nil,
              type: nil,
              verification_method: nil,
              tls_policy: nil,
              custom_client_ip_header: nil

    @type t :: %__MODULE__{
            domain: String.t(),
            type: String.t(),
            verification_method: String.t(),
            tls_policy: String.t(),
            custom_client_ip_header: String.t()
          }
  end

  @type endpoint :: String.t()
  @type params :: Params.t() | map()
  @type config :: Config.t()
  @type entity :: CustomDomain.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Configure a new custom domain.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Custom_Domains/post_custom_domains

  """
  @spec execute(endpoint, params, config) :: response
  def execute(endpoint, %Params{} = params, %Config{} = config) do
    execute(endpoint, params |> Util.to_map(), config)
  end

  def execute(endpoint, %{} = params, %Config{} = config) do
    body = params |> Util.remove_nil()

    Http.post(endpoint, body, config)
    |> case do
      {:ok, 201, body} -> {:ok, CustomDomain.from(body |> Jason.decode!()), body}
      error -> error
    end
  end
end
