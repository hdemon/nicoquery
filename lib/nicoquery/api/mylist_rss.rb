require 'active_support/core_ext'
require 'nicoquery/api/base'


module NicoQuery
  module Api
    class MylistRSS < NicoQuery::Api::Base

      def initialize(mylist_id)
        @dynamic_segment = mylist_id.to_s
        @params_array = params_array
      end

      def forbidden?
        @forbidden == true
      end

      private
      def host
        'www.nicovideo.jp'
      end

      def static_segment
        'mylist'
      end

      def params_array
        [format, 'numbers=1']
      end

      def format
        "rss=2.0"
      end
    end
  end
end
