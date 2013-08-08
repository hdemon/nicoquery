require 'rest_client'


module NicoQuery
  module Source
    class HttpClient
      def set_params(uri) @uri = uri end

      def get
        RestClient.get @uri.to_s
      end
    end
  end
end
