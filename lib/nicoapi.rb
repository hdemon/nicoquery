require "nicoapi/version"

require "nicoapi/getthumbinfo"
require "nicoapi/tag_search"
require "nicoapi/video_array"


module NicoAPI
  def getthumbinfo(video_id)
    instance = NicoAPI::GetThumbInfo.new
    instance.set video_id: video_id
    instance.get
  end

  module_function :getthumbinfo
end
