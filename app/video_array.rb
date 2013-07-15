require './app/http_client'
require './app/hash_mapper'


module NicoAPI
  class VideoArray
    include NicoAPI::HashMapper

    SCHEME = 'http'
    DOMAIN = 'i.nicovideo.jp/'
    RESOURCE = 'v3/video.array'

    def get(video_id_array)
      http_client = NicoAPI::HttpClient.instance
      uri = URI.join "#{SCHEME}://#{DOMAIN}/#{RESOURCE}?v=" + video_id_array.join(',')
      http_client.set_params uri
      map_to_hash http_client.get
    end
  end
end
