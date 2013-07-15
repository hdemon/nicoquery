require 'nori'
require './app/http_client'


module NicoAPI
  module VideoArray
    SCHEME = 'http'
    DOMAIN = 'i.nicovideo.jp/'
    RESOURCE = 'v3/video.array'

    def self.get(video_id_array)
      http_client = NicoAPI::HttpClient.instance
      uri = URI.join "#{SCHEME}://#{DOMAIN}/#{RESOURCE}?v=" + video_id_array.join(',')
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
