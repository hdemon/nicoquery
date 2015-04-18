require "nicoquery/api/tag_search_rss"
require "nicoquery/object/tag_search"
require "nicoquery/object_mapper/tag_search_rss"
require "nori"


module NicoQuery::Crawler
  module TagSearch
    def execute(tag: tag, sort: sort, order: order, &block)
      page = 0

      loop do
        command = nil
        page += 1

        tag_search_object = NicoQuery::Object::TagSearch.new tag: tag, sort: sort, order: order, page: page
        self.each_movie(tag_search_object.movies) do |movie|
          command = block.call movie
          break if command == :break || command != :continue
        end

        break if command == :break || command != :continue
      end
    end

    private

    def each_movie(parsed_movies, &block)
      while parsed_movies.length > 0 do
        block.call parsed_movies.shift
      end
    end

    module_function :execute
    module_function :each_movie
  end
end
