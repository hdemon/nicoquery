require 'active_support/core_ext'
require 'nicoquery/source/base'


module NicoQuery
  module Source
    class Mylist
      include NicoQuery::Source::Base

      def set(mylist_id: mylist_id)
        @dynamic_segment = mylist_id
        @params_array = params_array
      end

      private
      def host
        'www.nicovideo.jp'
      end

      def static_segment
        'mylist'
      end

      def params_array
        [format]
      end

      def format
        "rss=2.0"
      end
    end
  end
end
