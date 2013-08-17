require 'nicoquery/api/base'


module NicoQuery
  module Api
    class GetThumbInfo < NicoQuery::Api::Base
      def initialize(video_id)
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
