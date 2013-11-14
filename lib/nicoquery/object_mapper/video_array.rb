require "nori"
require "nicoquery/object_mapper/description"


module NicoQuery
  module ObjectMapper
    class VideoArray
      attr_reader :movies

      def initialize(xml)
        parser = Nori.new
        parsed_xml = parser.parse xml
        entire = parsed_xml['nicovideo_video_response']

        if entire['video_info'].is_a? Array
          @movies = entire['video_info'].each_with_object([]) do |movie, array|
            array << Video.new(movie)
          end
        elsif entire['video_info'].nil?
          @movies = []
        else
        # noriは子要素が複数の場合は配列に変換するが、1つの場合には配列にしない。
        # しかし、MylistRSSはitemsが配列であること前提にしているので、item要素が
        # 1つだけの場合にも配列に変換する必要がある。
          @movies = [ Video.new(entire['video_info']) ]
        end
      end

      class Video
        def initialize(parsed_xml)
          @hash = parsed_xml
        end

        def video_id
          @hash['video']['id']
        end

        def title
          @hash['video']['title']
        end

        def description
          @_description ||= Description.new @hash['video']['description']
        end

        def thumbnail_url
          @hash['video']['thumbnail_url']
        end

        def first_retrieve
          @hash['video']['first_retrieve'].to_time
        end

        def publish_date # alias
          first_retrieve
        end

        def length
          string = @hash['video']['length'].split(':')
          string[0].to_i * 60 + string[1].to_i
        end

        def movie_type
          @hash['video']['movie_type']
        end

        def view_counter
          @hash['video']['view_counter'].to_i
        end

        def comment_num
          @hash['video']['comment_num'].to_i
        end

        def mylist_counter
          @hash['video']['mylist_counter'].to_i
        end

        def size_low
          @hash['video']['size_low'].to_i
        end

        def tags
          @hash['tags']['tag_info'].each_with_object([]) do |tag, array|
            array << { text: tag['tag'] }
          end
        end
      end
    end
  end
end