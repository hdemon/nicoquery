require './app/http_client'
require './app/hash_mapper'


module NicoAPI
  class GetThumbInfo
    include NicoAPI::HashMapper

    SCHEME = 'http'
    DOMAIN = 'ext.nicovideo.jp'
    RESOURCE = 'api/getthumbinfo'

    def get(video_id)
      http_client = NicoAPI::HttpClient.instance
      uri = URI.join "#{SCHEME}://#{DOMAIN}/#{RESOURCE}/#{video_id}"
      http_client.set_params uri
      map_to_hash http_client.get
    end
  end
end
