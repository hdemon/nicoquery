require "nicoquery/version"


module NicoQuery
  def tag_search(tag: tag, sort: sort, order: order, &block)
    NicoCrawler::TagSearch.execute(tag: tag, sort: sort, order: order, &block)
  end

  module_function :tag_search
end
