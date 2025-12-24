defmodule Auth0.Common.UtilTest do
  use ExUnit.Case
  alias Auth0.Common.Util

  describe "hash/1" do
    test "generates SHA256 hash" do
      assert Util.hash("erin") ==
               <<124, 188, 203, 12, 76, 170, 223, 159, 205, 181, 30, 228, 87, 168, 40, 204, 114,
                 164, 88, 121, 131, 27, 91, 151, 138, 226, 226, 206, 252, 68, 151, 5>>
    end

    test "generates hash for empty string" do
      assert Util.hash("") |> is_binary()
    end
  end

  describe "hex_encode/1" do
    test "encodes string to hex" do
      assert Util.hex_encode("erin") == "6572696e"
    end
  end

  describe "hmac/2" do
    test "generates HMAC-SHA256 hash" do
      assert Util.hmac("secret", "erin") ==
               <<66, 116, 70, 47, 123, 250, 150, 31, 51, 11, 16, 118, 149, 254, 106, 254, 89, 65,
                 153, 52, 185, 191, 44, 50, 250, 254, 55, 172, 101, 31, 249, 250>>
    end
  end

  describe "uuid/0" do
    test "generates a uuid" do
      uuid = Util.uuid()
      assert is_binary(uuid)
    end
  end

  describe "remove_nil/1" do
    test "removes nil values from map" do
      assert Util.remove_nil(%{a: 1, b: nil, c: 3}) == %{a: 1, c: 3}
    end

    test "removes nil values from nested map" do
      assert Util.remove_nil(%{a: 1, b: %{c: nil, d: 2}}) == %{a: 1, b: %{d: 2}}
    end

    test "removes nil values from list in map" do
       assert Util.remove_nil(%{a: [%{b: nil, c: 1}, 2]}) == %{a: [%{c: 1}, 2]}
    end
  end

  describe "append_query/2" do
    test "appends query to endpoint" do
      assert Util.append_query("a=1", "/endpoint") == "/endpoint?a=1"
    end

    test "returns endpoint if query is empty" do
      assert Util.append_query("", "/endpoint") == "/endpoint"
    end
  end

  describe "convert_to_query/1" do
    test "converts map to query string" do
      query = Util.convert_to_query(%{a: 1, b: nil, c: 3})
      assert query =~ "a=1"
      assert query =~ "c=3"
      refute query =~ "b="
    end
  end

  describe "convert_to_form_body/1" do
    test "converts map to form body" do
      assert Util.convert_to_form_body(%{a: 1, b: nil}) == {:form, [a: 1]}
    end
  end

  describe "to_map/1" do
    test "converts struct to map" do
      struct = %URI{host: "example.com"}
      map = Util.to_map(struct)
      assert is_map(map)
      assert map[:host] == "example.com"
      refute Map.has_key?(map, :__struct__)
    end

    test "converts nested struct to map" do
        # Using a simple map structure to simulate nesting for basic test
        nested = %{a: %URI{host: "example.com"}}
        map = Util.to_map(nested)
        assert map.a[:host] == "example.com"
    end
  end

  describe "to_struct/2" do
    test "converts map to struct" do
      map = %{"host" => "example.com", "port" => 80}
      struct = Util.to_struct(map, URI)
      assert struct.host == "example.com"
      assert struct.port == 80
    end
  end

  describe "decode_json_or_string!/1" do
    test "decodes json string" do
      assert Util.decode_json_or_string!("{\"a\":1}") == %{"a" => 1}
    end

    test "returns string if not json" do
      assert Util.decode_json_or_string!("not json") == "not json"
    end
  end

  describe "decode_json!/1" do
     test "decodes json and converts keys to atoms" do
        assert Util.decode_json!("{\"a\":1}") == %{a: 1}
     end

     test "decodes nested json" do
         assert Util.decode_json!("{\"a\":{\"b\":1}}") == %{a: %{b: 1}}
     end
  end
end
