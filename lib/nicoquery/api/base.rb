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
        RestClient.get uri.to_s do |response, request, result, &block|
          case response.code
          when 200
            @forbidden = false
            response
          when 403
            @forbidden = true
            response
          end
        end
      end
    end
  end
end
