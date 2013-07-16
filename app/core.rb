require './app/http_client'
require './app/hash_mapper'


module NicoAPI
  class Base
    include NicoAPI::HashMapper

    def initialize
      @http_client = NicoAPI::HttpClient.instance
    end
  end
end
