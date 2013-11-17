require "nicoquery/api/video_array"
require "nicoquery/object_mapper/video_array"
require "nicoquery/object/movie"
require "nori"
require "pry"


module NicoQuery
  module Crawler
    module BulkScraping
      def execute(id_array, &block)
        @movies = []
        response = (NicoQuery::Api::VideoArray.new id_array).get
        @hash = NicoQuery::ObjectMapper::VideoArray.new response[:body]

        @hash.movies.each do |movie|
          m = NicoQuery::Object::Movie.new movie.video_id
          m.set_video_array_source movie
          block.call m
        end
      end

      module_function :execute
    end
  end
end
