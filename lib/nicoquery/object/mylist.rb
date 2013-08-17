require "nicoquery/api/mylist_rss"
require "nicoquery/object_mapper/mylist_rss"


module NicoQuery
  module Object
    class Mylist
      def initialize(mylist_id)
        @mylist_id = mylist_id
        @source = (NicoQuery::Api::MylistRSS.new mylist_id).get
        @hash = (NicoQuery::ObjectMapper::MylistRSS::Meta.new).parse @source
      end

      def mylist_id
        @mylist_id
      end

      def title
        @title ||= @hash.title.force_encoding('utf-8')
      end

      def url
        @publish_date ||= @hash.publish_date
      end

      def description
        @decription ||= @hash.decription
      end

      def publish_date
        @publish_date ||= @hash.publish_date
      end

      def creator
        @creator ||= @hash.creator
      end
    end
  end
end


# <title>マイリスト to_test‐ニコニコ動画</title>
# <link>http://www.nicovideo.jp/mylist/38369702</link>
# <atom:link rel="self" type="application/rss+xml" href="http://www.nicovideo.jp/mylist/38369702?rss=2.0"/>
# <description></description>
# <pubDate>Sat, 17 Aug 2013 22:51:40 +0900</pubDate>
# <lastBuildDate>Sat, 17 Aug 2013 22:51:40 +0900</lastBuildDate>
# <generator>ニコニコ動画</generator>
# <dc:creator>うえおに</dc:creator>
# <language>ja-jp</language>
# <copyright>(c) niwango, inc. All rights reserved.</copyright>
# <docs>http://blogs.law.harvard.edu/tech/rss</docs>
