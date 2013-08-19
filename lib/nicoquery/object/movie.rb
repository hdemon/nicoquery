require "nicoquery/api/getthumbinfo"
require "nicoquery/object_mapper/getthumbinfo"


module NicoQuery
  module Object
    class Movie
      attr_reader :video_id

      [
        'title',
        'url',
        # 'thread_id',
        'view_counter',
        'comment_num',
        'mylist_counter',
        'publish_date',
        'description',
      ].each do |field_name|
        define_method(field_name) do
          source =
            @source['mylist_rss'].presence ||
            @source['tag_seach'].presence ||
            @source['gethumbinfo'].presence ||
            Proc.new do
              source = (NicoQuery::Api::GetThumbInfo.new @video_id).get
              set_getthumbinfo_source(NicoQuery::ObjectMapper::GetThumbInfo.new source)
            end.call

          source.send field_name
        end
      end

      [
        'movie_type',
        'size_high',
        'size_low',
        'last_res_body',
        'thumb_type',
        'embeddable',
        'no_live_play',
        'user_id',
        'tags',
      ].each do |field_name|
        define_method(field_name) do
          source =
            @source['gethumbinfo'].presence ||
            @source['video_array'].presence ||
            Proc.new do
              source = (NicoQuery::Api::GetThumbInfo.new @video_id).get
              set_getthumbinfo_source(NicoQuery::ObjectMapper::GetThumbInfo.new source)
            end.call

          source.send field_name
        end
      end

      def initialize(video_id)
        @source = {}
        @video_id = video_id
      end

      def set_getthumbinfo_source(hash)
        @source['getthumbinfo'] ||= hash
      end

      def set_mylist_rss_source(hash)
        @source['mylist_rss'] ||= hash
      end

      def set_tag_search_source(hash)
        @source['tag_search'] ||= hash
      end

    end
  end
end
