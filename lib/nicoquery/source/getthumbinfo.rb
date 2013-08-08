require 'nicoquery/source/base'


module NicoQuery
  module Source
    class GetThumbInfo
      include NicoQuery::Source::Base

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
end
