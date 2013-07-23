require 'rest_client'
require './app/http_client'


module NicoAPI
  module Base
    def scheme
      'http'
    end

    def params
      @params_array.join('&')
    end

    def uri
      URI.escape("#{scheme}://#{host}/#{static_segment}/#{@dynamic_segment}?#{params}")
    end

    def get
      http_client = NicoAPI::HttpClient.instance
      http_client.set_params uri.to_s
      http_client.get
    end


    # module_function :get
  end
end
