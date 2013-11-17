require 'rest_client'
require 'active_support/all'


module NicoQuery
  module Api
    class Base
      attr_reader :forbidden

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
        res = nil

        RestClient.get uri.to_s do |response|
          res = response
        end

        { body: res.to_s, headers: res.headers, status_code: res.code }
      end
    end
  end
end
