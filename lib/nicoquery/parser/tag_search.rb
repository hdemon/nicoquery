require "nori"
require "nokogiri"


module NicoQuery
  module Parser
    class TagSearch
      def initialize
        @parser = Nori.new
      end

      def parse(xml)
        @object = (@parser.parse xml)["rss"]["channel"]

        @items = @object["item"].map do |item_object|
          Item.new item_object
        end
      end

      def items
        @items
      end

      def tag
        @object["title"].scan(/(?<=タグ\s).+(?=\‐ニコニコ動画)/)[0].split(' ')
      end

      def publish_date
        Time.parse @object["pubDate"]
      end

      def last_build_date
        Time.parse @object["lastBuildDate"]
      end

      class Item
        def initialize(object)
          @object = object
        end

        def title
          @object["title"]
        end

        def video_id
          url.scan(/(sm|nm)\d{1,}\Z/)
          $&
        end

        def url
          @object["link"]
        end

        def publish_date
          Time.parse @object["pubDate"]
        end

        def thumbnail_url
          description.raw_text.scan(/(?<=src\=\").{1,}(?=\"\swidth)/)
          $&
        end

        def description
          @_description ||= Description.new @object["description"]
        end

        def length
          description.raw_text.scan(/(?<=class\=\"nico\-info\-length\"\>)\d{1,}\:\d{1,2}(?=\<\/strong\>)/)
          length_string = $&.to_s.split(':')
          length_string[0].to_i * 60 + length_string[1].to_i
        end

        class Description
          attr_reader :raw_text

          def initialize(raw_text)
            @raw_text = raw_text.to_s
          end

          def text
            @raw_text.scan /(?<=class\=\"nico\-description\"\>).{1,}(?=\<\/p\>)/
            $&
          end

          def movie_references
            # is this the high road?
            text.scan(/((sm|nm)\d{1,})/).map {|e| e[0]}
          end

          def mylist_references
            text.scan /(?<=mylist\/)\d{1,}/
          end

          def community_references
            text.scan /co\d{1,}/
          end

          def seiga_references
            text.scan /im\d{1,}/
          end
        end
      end

    end
  end
end
