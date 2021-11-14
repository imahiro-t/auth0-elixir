defmodule Auth0.Common.Util do
  @moduledoc """
  Documentation for Util.
  """

  use Bitwise

  @doc """
  Generate SHA256 hash value.

  ## Examples

      iex> Auth0.Common.Util.hash("erin")
      <<124, 188, 203, 12, 76, 170, 223, 159, 205, 181, 30, 228, 87, 168, 40, 204,
        114, 164, 88, 121, 131, 27, 91, 151, 138, 226, 226, 206, 252, 68, 151, 5>>

  """
  @spec hash(String.t()) :: binary
  def hash(str \\ "") do
    :crypto.hash(:sha256, str)
  end

  @doc """
  Encode to Base 16 value with lower case.

  ## Examples

      iex> Auth0.Common.Util.hex_encode("erin")
      "6572696e"

  """
  @spec hex_encode(String.t()) :: String.t()
  def hex_encode(str \\ "") do
    str
    |> Base.encode16(case: :lower)
  end

  @doc """
  Generate HMAC-SHA256 hash value.

  ## Examples

      iex> Auth0.Common.Util.hmac("secret", "erin")
      <<66, 116, 70, 47, 123, 250, 150, 31, 51, 11, 16, 118, 149, 254, 106, 254, 89,
        65, 153, 52, 185, 191, 44, 50, 250, 254, 55, 172, 101, 31, 249, 250>>

  """
  @spec hmac(String.t(), String.t()) :: binary
  def hmac(secret, str) do
    :crypto.mac(:hmac, :sha256, secret, str)
  end

  @doc """
  Generate UUID4 value.
  """
  @spec uuid() :: String.t()
  def uuid() do
    <<b1::binary-size(5), x, b2::binary-size(1), y, b3::binary-size(8)>> =
      :crypto.strong_rand_bytes(16)

    (b1 <> <<(x &&& 0x0F) ||| 0x40>> <> b2 <> <<(y &&& 0x3F) ||| 0x80>> <> b3) |> Base.encode16()
  end

  @doc """
  Remove nil value from map recursively.

  ## Examples

      iex> Auth0.Common.Util.remove_nil(%{a: 1, b: nil, c: 3})
      %{a: 1, c: 3}

      iex> Auth0.Common.Util.remove_nil(%{:a => 1, :b => nil, :c => 3, "d" => nil, "f" => 5})
      %{:a => 1, :c => 3, "f" => 5}
  """
  @spec remove_nil(map) :: map
  def remove_nil(%{} = map) do
    map
    |> Enum.reject(fn {_, v} -> is_nil(v) end)
    |> Enum.map(fn {k, v} ->
      {k,
       case v do
         v when v |> is_map ->
           remove_nil(v)

         v when v |> is_list ->
           v |> Enum.map(fn v2 -> if(v2 |> is_map, do: remove_nil(v2), else: v2) end)

         v ->
           v
       end}
    end)
    |> Map.new()
  end

  @doc """
  append query to endpoint.

  ## Examples

      iex> Auth0.Common.Util.append_query("a=1&c=3&d=erin%20the%20black", "/hoge/fuga")
      "/hoge/fuga?a=1&c=3&d=erin%20the%20black"
  """
  @spec append_query(String.t(), String.t()) :: String.t()
  def append_query(query, endpoint) do
    case query do
      "" -> endpoint
      query -> "#{endpoint}?#{query}"
    end
  end

  @doc """
  Convert to query from map. Nil value is removed.

  ## Examples

      iex> Auth0.Common.Util.encode_query(%{a: 1, b: nil, c: 3, d: "erin the black"})
      "a=1&c=3&d=erin%20the%20black"
  """
  @spec convert_to_query(map) :: String.t()
  def convert_to_query(%{} = map) do
    map
    |> remove_nil
    |> URI.encode_query(:rfc3986)
  end

  @doc """
  Convert to form body from map. Nil value is removed.

  ## Examples

      iex> Auth0.Common.Util.encode_form_body(%{a: 1, b: nil, c: 3, d: "erin the black"})
      {:form, [a: 1, b: nil, c: 3, d: "erin the black"]}
  """
  @spec convert_to_form_body(map) :: {:form, keyword}
  def convert_to_form_body(%{} = map) do
    {:form, map |> remove_nil |> Map.to_list()}
  end

  @doc """
  Convert struct to map recursively.
  """
  @spec to_map(struct) :: map
  def to_map(struct) do
    if(struct |> is_struct, do: struct |> Map.from_struct(), else: struct)
    |> Enum.map(fn {k, v} ->
      {k,
       case v do
         v when v |> is_map ->
           to_map(v)

         v when v |> is_list ->
           v |> Enum.map(fn v2 -> if(v2 |> is_map, do: to_map(v2), else: v2) end)

         v ->
           v
       end}
    end)
    |> Map.new()
  end

  @doc """
  Convert map to struct and string keys are considered.
  """
  @spec to_struct(map, module) :: struct
  def to_struct(map, module) do
    struct(
      module,
      map |> Map.new(fn {k, v} -> {if(k |> is_atom, do: k, else: String.to_atom(k)), v} end)
    )
  end

  @doc """
  Decode json using atom key.
  """
  @spec decode_json!(String.t()) :: map | list
  def decode_json!(value) do
    value |> Jason.decode!() |> key_to_atom()
  end

  defp key_to_atom(value) when value |> is_list do
    value |> Enum.map(&key_to_atom/1)
  end

  defp key_to_atom(value) when value |> is_map do
    value
    |> Enum.map(fn {k, v} ->
      {
        if(k |> is_atom, do: k, else: String.to_atom(k)),
        v |> key_to_atom()
      }
    end)
    |> Map.new()
  end

  defp key_to_atom(value), do: value
end
