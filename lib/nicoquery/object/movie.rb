require "pry"


module NicoQuery
  module Object
    attr_reader :video_id

    class Movie
      [
        'title',
        'url',
        'thread_id',
        'publish_date',
        'description',
      ].each do |field_name|
        define_method(field_name) do
          if @source['mylist_rss'].present?
            @source['mylist_rss'].send field_name
          elsif @source['gethumbinfo'].present?
            @source['gethumbinfo'].present?.send field_name
          end
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
    end
  end
end
