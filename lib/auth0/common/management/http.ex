defmodule Auth0.Common.Management.Http do
  @moduledoc """
  Documentation for Auth0 Management HTTP.

  This module manages http request for Auth0 Management API.

  """

  alias Auth0.Config
  alias Auth0.Common.Management.TokenManager

  @type endpoint :: String.t()
  @type body :: map | list
  @type multipart :: {:multipart, list}
  @type config :: Config.t()
  @type response :: {:ok, integer, String.t()} | {:error, integer, term} | {:error, term}
  @type method :: :get | :post | :put | :patch | :delete | :options | :head
  @type headers :: map
  @type raw_response ::
          {:ok,
           HTTPoison.Response.t()
           | HTTPoison.AsyncResponse.t()
           | HTTPoison.MaybeRedirect.t()}
          | {:error, HTTPoison.Error.t()}

  @request_headers %{"Content-Type" => "application/json"}
  @post_headers %{"Content-Type" => "application/json"}
  @patch_headers %{"Content-Type" => "application/json"}
  @put_headers %{"Content-Type" => "application/json"}
  @get_headers %{}
  @delete_headers %{}
  @multipart_post_headers %{"Content-Type" => "multipart/form-data"}
  @max_request_retry_count 10
  @max_request_retry_jitter 100
  @max_request_retry_delay 1000
  @min_request_retry_delay 100

  @doc """
  Request Auth0 management rest api simply.

  """
  @spec raw_request(method, endpoint, body, headers, config) :: raw_response
  def raw_request(method, endpoint, body \\ %{}, headers \\ nil, %Config{} = config \\ %Config{}) do
    headers =
      if headers |> is_nil do
        case method do
          :get -> @get_headers
          :post -> @post_headers
          :put -> @put_headers
          :patch -> @patch_headers
          :delete -> @delete_headers
        end
      else
        headers
      end
      |> set_correlation_id(config)
      |> set_authorization(config)

    url = endpoint |> get_url(config)

    HTTPoison.request(method, url, body |> Jason.encode!(), headers)
  end

  @doc """
  POST Auth0 management rest api.

  """
  @spec post(endpoint, body, config) :: response
  def post(endpoint, body, %Config{} = config) do
    headers =
      @post_headers
      |> set_correlation_id(config)
      |> set_authorization(config)

    request_with_retry(
      fn url -> HTTPoison.post(url, body |> Jason.encode!(), headers) end,
      endpoint,
      config
    )
  end

  @doc """
  PATCH Auth0 management rest api.

  """
  @spec patch(endpoint, body, config) :: response
  def patch(endpoint, body, %Config{} = config) do
    headers =
      @patch_headers
      |> set_correlation_id(config)
      |> set_authorization(config)

    request_with_retry(
      fn url -> HTTPoison.patch(url, body |> Jason.encode!(), headers) end,
      endpoint,
      config
    )
  end

  @doc """
  PUT Auth0 management rest api.

  """
  @spec put(endpoint, body, config) :: response
  def put(endpoint, body, %Config{} = config) do
    headers =
      @put_headers
      |> set_correlation_id(config)
      |> set_authorization(config)

    request_with_retry(
      fn url -> HTTPoison.put(url, body |> Jason.encode!(), headers) end,
      endpoint,
      config
    )
  end

  @doc """
  GET Auth0 management rest api.

  """
  @spec get(endpoint, config) :: response
  def get(endpoint, %Config{} = config) do
    headers =
      @get_headers
      |> set_correlation_id(config)
      |> set_authorization(config)

    request_with_retry(fn url -> HTTPoison.get(url, headers) end, endpoint, config)
  end

  @doc """
  DELETE Auth0 management rest api.

  """
  @spec delete(endpoint, config) :: response
  def delete(endpoint, %Config{} = config) do
    headers =
      @delete_headers
      |> set_correlation_id(config)
      |> set_authorization(config)

    request_with_retry(fn url -> HTTPoison.delete(url, headers) end, endpoint, config)
  end

  @doc """
  DELETE Auth0 management rest api. (with body)

  """
  @spec delete(endpoint, body, config) :: response
  def delete(endpoint, body, %Config{} = config) do
    headers =
      @request_headers
      |> set_correlation_id(config)
      |> set_authorization(config)

    request_with_retry(
      fn url -> HTTPoison.request(:delete, url, body |> Jason.encode!(), headers) end,
      endpoint,
      config
    )
  end

  @doc """
  MULTIPART POST Auth0 management rest api.

  """
  @spec multipart_post(endpoint, multipart, config) :: response
  def multipart_post(endpoint, multipart, %Config{} = config) do
    headers =
      @multipart_post_headers
      |> set_correlation_id(config)
      |> set_authorization(config)

    request_with_retry(
      fn url -> HTTPoison.post(url, multipart, headers) |> IO.inspect() end,
      endpoint,
      config
    )
  end

  defp request_with_retry(request_func, endpoint, %Config{} = config, retry_count \\ 0) do
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

  defp set_correlation_id(headers, %Config{correlation_id: nil}), do: headers

  defp set_correlation_id(headers, %Config{correlation_id: correlation_id}),
    do: headers |> Map.put("x-correlation-id", correlation_id)

  defp set_authorization(headers, %Config{} = config) do
    case config |> Config.get_api_token() do
      nil ->
        case config |> TokenManager.get_token() do
          nil ->
            headers

          access_token ->
            headers |> Map.put("Authorization", "Bearer #{access_token}")
        end

      api_token ->
        headers |> Map.put("Authorization", "Bearer #{api_token}")
    end
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
