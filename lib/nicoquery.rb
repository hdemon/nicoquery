require "nicoquery/version"
require "nicoquery/crawler"


module NicoQuery
  def tag_search(tag: tag, sort: sort, order: order, &block)
    NicoQuery::Crawler::TagSearch.execute(tag: tag, sort: sort, order: order, &block)
  end

  module_function :tag_search
end
;