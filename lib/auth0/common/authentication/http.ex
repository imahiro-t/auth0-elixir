defmodule Auth0.Common.Authentication.Http do
  @moduledoc false

  alias Auth0.Config

  @type request_func :: function
  @type endpoint :: String.t()
  @type config :: Config.t()
  @type retry_count :: integer
  @type response :: {:ok, integer, String.t()} | {:error, integer, term} | {:error, term}

  @max_request_retry_count 10
  @max_request_retry_jitter 100
  @max_request_retry_delay 1000
  @min_request_retry_delay 100

  @doc """
  Request of Auth0 authentication rest api.

  """
  @spec request_with_retry(request_func, endpoint, config, retry_count) :: response
  def request_with_retry(request_func, endpoint, %Config{} = config, retry_count \\ 0) do
    url = endpoint |> get_url(config)
    max_request_retry_count = config |> get_max_request_retry_count

    case request_func.(url) do
      {:ok, %HTTPoison.Response{status_code: 429}} when max_request_retry_count > retry_count ->
        retry_count = retry_count + 1
        exponential_delay(retry_count)
        request_with_retry(request_func, endpoint, config, retry_count)

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}}
      when status_code in [200, 201, 202, 204] ->
        {:ok, status_code, body}

      {:ok, %HTTPoison.Response{status_code: 302, headers: headers}} ->
        location =
          Enum.filter(headers, fn {key, _} -> key |> String.match?(~r/\Alocation\z/i) end)
          |> Enum.map(fn {_, value} -> value end)
          |> List.first()

        {:ok, 302, location}

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, status_code, body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp get_url(endpoint, %Config{} = config) do
    "https://#{Config.get_domain(config)}#{endpoint}"
  end

  defp get_max_request_retry_count(%Config{} = config),
    do: min(Config.get_max_request_retry_count(config), @max_request_retry_count)

  defp exponential_delay(retry_count) do
    request_retry_jitter = Enum.random(0..@max_request_retry_jitter)

    max(
      @min_request_retry_delay,
      min(@max_request_retry_delay, 100 * Integer.pow(2, retry_count - 1) + request_retry_jitter)
    )
    |> Process.sleep()
  end
end
