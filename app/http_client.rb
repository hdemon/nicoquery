require 'rest_client'
require 'singleton'


module NicoAPI
  class HttpClient
    include Singleton

    def set_params(uri) @uri = uri end

    def get
      RestClient.get @uri.to_s
    end
  end
end
