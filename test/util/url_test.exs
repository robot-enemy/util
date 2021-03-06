defmodule Util.URLTest do
  @moduledoc false
  use ExUnit.Case
  import Util.URL, only: [
    strip_url_params: 1,
    strip_url_params: 2,
    utm_params: 0,
  ]

  describe "strip_utm_params/1" do

    test "should strip utm params from url string" do
      for utm_param <- utm_params() do
        url = "https://www.example.com?first=1&#{utm_param}=something&last=0"
        assert strip_url_params(url)
                == "https://www.example.com?first=1&last=0"
      end
    end

    test "should do nothing if no params" do
      url = "https://www.example.com"

      assert strip_url_params(url) == url
    end

  end

  describe "strip_url_params/2" do

    test "should strip the provided params from url string" do
      url = "https://www.example.com?first=1&something=BOOM&last=0"
      assert strip_url_params(url, ["something"])
              == "https://www.example.com?first=1&last=0"
    end

    test "should strip a param without a value" do
      url = "https://www.example.com?first=1&something&last=0"
      assert strip_url_params(url, ["something"])
              == "https://www.example.com?first=1&last=0"
    end

  end

end
