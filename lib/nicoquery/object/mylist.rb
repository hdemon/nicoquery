require "nicoquery/api/mylist_rss"
require "nicoquery/object_mapper/mylist_rss"
require "nicoquery/object/movie"


module NicoQuery
  module Object
    class Mylist
      attr_accessor :movies

      [
        'title',
        'mylist_id',
        'url',
        'link',
        'description',
        'publish_date',
        'last_build_date',
        'creator',
      ].each do |field_name|
        define_method(field_name) { @hash.meta.send field_name }
      end

      def initialize(mylist_id)
        @movies = []
        @mylist_id = mylist_id
        @response = (NicoQuery::Api::MylistRSS.new mylist_id).get
        @hash = NicoQuery::ObjectMapper::MylistRSS.new @response[:body]

        return if @hash.items.nil?
        @hash.items.map do |item|
          movie = NicoQuery::Object::Movie.new item.video_id.presence || item.thread_id
          movie.set_mylist_rss_source item
          @movies.push movie
        end
      end

      def available?
        [exist?, !forbidden?].all?
      end

      def forbidden?
        @response[:status_code] == 403
      end

      def exist?
        @response[:status_code] != 404
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
