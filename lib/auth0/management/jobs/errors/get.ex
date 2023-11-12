defmodule Auth0.Management.Jobs.Errors.Get do
  @moduledoc false

  alias Auth0.Config
  alias Auth0.Common.Management.Http
  alias Auth0.Entity.JobsErrors

  @type endpoint :: String.t()
  @type id :: String.t()
  @type config :: Config.t()
  @type entity :: JobsErrors.t()
  @type response_body :: String.t()
  @type response :: {:ok, entity, response_body} | {:error, integer, term} | {:error, term}

  @doc """
  Get job error details.

  ## see
  https://auth0.com/docs/api/management/v2/#!/Jobs/get_errors

  """
  @spec execute(endpoint, id, config) :: response
  def execute(endpoint, id, %Config{} = config) do
    endpoint
    |> String.replace("{id}", id)
    |> Http.get(config)
    |> case do
      {:ok, 200, body} -> {:ok, JobsErrors.from(body |> Jason.decode!()), body}
      {:ok, 204, body} -> {:ok, "", body}
      error -> error
    end
  end
end
