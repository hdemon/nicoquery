require 'nicoapi/http_client'


module NicoAPI
  module Base
    def scheme
      'http'
    end

    def params
      @params_array.join('&')
    end

    def path
      if @dynamic_segment.present?
        static_segment + '/' + @dynamic_segment
      else
        static_segment
      end
    end

    def uri
      _uri = scheme + "://" + [ ([host, path].join('/')), params].join('?')
      URI.escape _uri
    end

    def get
      http_client = NicoAPI::HttpClient.instance
      http_client.set_params uri.to_s
      http_client.get
    end
  end
end
