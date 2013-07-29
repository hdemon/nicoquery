require "nicoapi/core/version"

require "nicoapi/core/getthumbinfo"
require "nicoapi/core/tag_search"
require "nicoapi/core/video_array"


module NicoAPI
  def getthumbinfo(video_id)
    instance = NicoAPI::GetThumbInfo.new
    instance.set video_id
    instance.get
  end

  def video_array(video_id_array)
    instance = NicoAPI::VideoArray.new
    instance.set video_id_array
    instance.get
  end

  def tag_search(tag: tag, sort: sort, order: order)
    instance = NicoAPI::TagSearch.new
    instance.set tag: tag, sort: sort, order: order
    instance.get
  end

  module_function :getthumbinfo
  module_function :video_array
  module_function :tag_search
end
