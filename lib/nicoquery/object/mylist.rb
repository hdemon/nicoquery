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
        define_method(field_name) do
          if available?
            @source_object.meta.send field_name
          else
            nil
          end
        end
      end

      def initialize(mylist_id)
        @movies = []
        @mylist_id = mylist_id
        @response_xml = (NicoQuery::Api::MylistRSS.new mylist_id).get
        @source_object = source_object
        set_hash_items
      end

      def available?
        [exist?, !forbidden?].all?
      end

      def forbidden?
        @response_xml[:status_code] == 403
      end

      def exist?
        @response_xml[:status_code] != 404
      end

      private

      def source_object
        if available?
          NicoQuery::ObjectMapper::MylistRSS.new @response_xml[:body]
        else
          NicoQuery::ObjectMapper::MylistRSS.new null_response_xml
        end
      end

      def set_hash_items
        @source_object.items.each do |item|
          movie = NicoQuery::Object::Movie.new item.video_id.presence || item.thread_id
          movie.set_mylist_rss_source item
          @movies.push movie
        end
      end

      def null_response_xml
        <<-EOS
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0"
     xmlns:dc="http://purl.org/dc/elements/1.1/"
     xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title></title>
    <link></link>
    <atom:link rel="self" type="application/rss+xml" href="http://www.nicovideo.jp/mylist/38350049?rss=2.0"/>
    <description></description>
    <pubDate></pubDate>
    <lastBuildDate></lastBuildDate>
    <generator></generator>
    <dc:creator></dc:creator>
    <language></language>
    <copyright></copyright>
    <docs></docs>
  </channel>
</rss>
        EOS
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
