require "nicoquery/source/getthumbinfo"
require "nicoquery/source/tag_search"
require "nicoquery/source/video_array"


module NicoQuery
  module Source
    def getthumbinfo(video_id)
      instance = NicoQuery::Source::GetThumbInfo.new
      instance.set video_id
      instance.get
    end

    def video_array(video_id_array)
      instance = NicoQuery::Source::VideoArray.new
      instance.set video_id_array
      instance.get
    end

    def tag_search(tag: tag, sort: sort, order: order, page: page)
      instance = NicoQuery::Source::TagSearch.new
      instance.set tag: tag, sort: sort, order: order, page: page
      instance.get
    end

    module_function :getthumbinfo
    module_function :video_array
    module_function :tag_search
  end
end
