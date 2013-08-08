require "nicoapi"
require "nicoquery/parser"
require "nori"


module NicoQuery
  module Crawler
    module TagSearch
      def execute(tag: tag, sort: sort, order: order, &block)
        parser = NicoQuery::Parser::TagSearch.new
        page = 0

        loop do
          command = nil
          page += 1

          result = NicoAPI.tag_search(tag: tag, sort: sort, order: order, page: page)
          parser.parse result

          self.each_movie(parser.items) do |movie|
            command = block.call movie
            break if command == :break || command != :continue
          end

          break if command == :break || command != :continue
        end
      end

      private

      def continue; :continue end
      def stop; :stop end

      def each_movie(parsed_movies, &block)
        while parsed_movies.length > 0 do
          block.call parsed_movies.shift
        end
      end

      module_function :execute
      module_function :each_movie
    end
  end
end
