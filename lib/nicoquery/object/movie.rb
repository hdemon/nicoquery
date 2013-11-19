require "nicoquery/api/getthumbinfo"
require "nicoquery/object_mapper/getthumbinfo"


module NicoQuery
  module Object
    class Movie
      attr_reader :video_id

      [
        'title',
        'url',
        'thread_id',
        'view_counter',
        'comment_num',
        'mylist_counter',
        'publish_date',
        'description',
      ].each do |field_name|
        define_method(field_name) do
          source =
            @source[:mylist_rss].presence ||
            @source[:tag_search_rss].presence ||
            @source[:video_array].presence ||
            @source[:getthumbinfo].presence ||
            Proc.new { get_and_set_getthumbinfo_source; @source[:getthumbinfo] }.call

          # TODO: this is temporary measure.
          if source.tags == nil then source.tags == [] end

          source.send field_name
        end
      end

      [
        'movie_type',
        # 'size_high',
        'size_low',
        # 'last_res_body',
        # 'thumb_type',
        # 'embeddable',
        # 'no_live_play',
        # 'user_id',
        'tags',
      ].each do |field_name|
        define_method(field_name) do
          source =
            @source[:getthumbinfo].presence ||
            @source[:video_array].presence ||
            Proc.new { get_and_set_getthumbinfo_source; @source[:getthumbinfo] }.call

          source.send field_name
        end
      end

      def initialize(video_id_or_thread_id)
        @source = {}
        @response = {}

        if video_id_or_thread_id.to_s.match(/sm|nm/)
          @video_id = video_id_or_thread_id
        else
          @thread_id = video_id_or_thread_id
        end
      end

      def available?
        [exist?, !deleted?].all?
      end

      def community?
        unless @source[:video_array].present?
          get_and_set_video_array_source
        end
        @source[:video_array].community?
      end

      def deleted?
        unless @source[:getthumbinfo].present?
          get_and_set_getthumbinfo_source
        end
        @source[:getthumbinfo].deleted?
      end

      def exist?
        unless @source[:getthumbinfo].present?
          get_and_set_getthumbinfo_source
        end
        @source[:getthumbinfo].exist?
      end

      def set_getthumbinfo_source(source_object)
        @source[:getthumbinfo] ||= source_object
      end

      def set_mylist_rss_source(source_object)
        @source[:mylist_rss] ||= source_object
      end

      def set_tag_search_rss_source(source_object)
        @source[:tag_search_rss] ||= source_object
      end

      def set_video_array_source(source_object)
        @source[:video_array] ||= source_object
      end

      def get_and_set_getthumbinfo_source
        @response[:getthumbinfo] = (NicoQuery::Api::GetThumbInfo.new(@video_id || @thread_id)).get
        set_getthumbinfo_source(NicoQuery::ObjectMapper::GetThumbInfo.new @response[:getthumbinfo][:body])
      end

      def get_and_set_video_array_source
        @response[:video_array] = (NicoQuery::Api::VideoArray.new([@video_id || @thread_id])).get
        parsed = (NicoQuery::ObjectMapper::VideoArray.new @response[:video_array][:body])
        set_video_array_source parsed.movies[0]
      end
    end
  end
end
