require "nicoquery/source/version"

require "nicoquery/source"


module NicoQuery
  def tag_search(tag: tag, sort: sort, order: order, &block)
    NicoCrawler::TagSearch.execute(tag: tag, sort: sort, order: order, &block)
  end

  module_function :tag_search
end



module NicoQuery
  def getthumbinfo(video_id)
    instance = NicoQuery::GetThumbInfo.new
    instance.set video_id
    instance.get
  end

  def video_array(video_id_array)
    instance = NicoQuery::VideoArray.new
    instance.set video_id_array
    instance.get
  end

  def tag_search(tag: tag, sort: sort, order: order, page: page)
    instance = NicoQuery::TagSearch.new
    instance.set tag: tag, sort: sort, order: order, page: page
    instance.get
  end

  module_function :getthumbinfo
  module_function :video_array
  module_function :tag_search
end
