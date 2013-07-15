require 'nori'
require './app/http_client'


module NicoAPI
  module GetThumbInfo
    SCHEME = 'http'
    DOMAIN = 'ext.nicovideo.jp'
    RESOURCE = 'api/getthumbinfo'

    def self.get(video_id)
      http_client = NicoAPI::HttpClient.instance
      uri = URI.join "#{SCHEME}://#{DOMAIN}/#{RESOURCE}/#{video_id}"
      http_client.set_params uri
      map_to_hash http_client.get
    end

    private

    def self.map_to_hash(xml)
      parser = Nori.new
      parser.parse xml
    end
  end
end
