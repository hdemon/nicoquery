require 'nicoquery/source/base'


module NicoQuery
  module Source
    class VideoArray
      include NicoQuery::Source::Base

      def set(video_id_array)
        @dynamic_segment = ''
        @params_array = params_array video_id_array
      end

      private
      def host
        'i.nicovideo.jp'
      end

      def static_segment
        'v3/video.array'
      end

      # video.array APIは動的セグメントではなく、URIパラメータとして動画を指定する。
      def params_array(video_id_array)
        ['v=' + video_id_array.join(',')]
      end
    end
  end
end
