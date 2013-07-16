require './app/core'
require './app/hash_mapper'


module NicoAPI
  class VideoArray < Base
    SCHEME = 'http'
    DOMAIN = 'i.nicovideo.jp/'
    RESOURCE = 'v3/video.array'

    def get(video_id_array)
      uri = URI.join "#{SCHEME}://#{DOMAIN}/#{RESOURCE}?v=" + video_id_array.join(',')
      @http_client.set_params uri
      map_to_hash @http_client.get
    end
  end
end
