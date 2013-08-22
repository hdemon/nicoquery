require "nicoquery/api/tag_search_rss"
require "nicoquery/object/tag_search"
require "nicoquery/object_mapper/tag_search_rss"
require "nicoquery/object/movie"


module NicoQuery
  module Object
    class TagSearch
      attr_accessor :movies

      [
        'title',
        'url',
        'link',
        'description',
        'publish_date',
        'creator',
      ].each do |field_name|
        define_method(field_name) { @hash.meta.send field_name }
      end

      def initialize(tag: tag, sort: sort, order: order, page: page)
        @movies = []
        source = (NicoQuery::Api::TagSearchRss.new(tag: tag, sort: sort, order: order, page: page)).get
        @hash = NicoQuery::ObjectMapper::TagSearchRss.new source

        @hash.items.map do |item|
          movie = NicoQuery::Object::Movie.new item.video_id
          movie.set_tag_search_rss_source item
          @movies.push movie
        end
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
