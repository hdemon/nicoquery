require "nicoquery/version"
require "nicoquery/crawler/tag_search"
require "nicoquery/object/mylist"
require "nicoquery/object/movie"


module NicoQuery
  def tag_search(tag: tag, sort: sort, order: order, &block)
    NicoQuery::Crawler::TagSearch.execute(tag: tag, sort: sort, order: order, &block)
  end

  def mylist(mylist_id)
    NicoQuery::Object::Mylist.new mylist_id
  end

  def movie(video_id)
    NicoQuery::Object::Movie.new video_id
  end

  module_function :tag_search
  module_function :mylist
  module_function :movie
end
