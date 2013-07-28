require 'nicoapi/base'


module NicoAPI
  class GetThumbInfo
    include NicoAPI::Base

    def set(video_id)
      @dynamic_segment = video_id
      @params_array = []
    end

    private
    def host
      'ext.nicovideo.jp'
    end

    def static_segment
      'api/getthumbinfo'
    end
  end
end
