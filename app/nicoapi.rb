require './app/http_client'
require './app/base'


module NicoAPI
  class << self
    include NicoAPI::Base

    def tag_search(string: string, order: order, asc: asc)
      @scheme = 'http'
      @host = 'www.nicovideo.jp'
      @static_segment = 'tag'
      @dynamic_segment = string

      @params_array = []
      @params_array.push "rss=2.0"

      get
    end
  end
end
