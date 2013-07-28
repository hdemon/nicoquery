require 'nicoapi/video_array'


describe "VideoArray" do
  before do
    @instance = NicoAPI::VideoArray.new
    @instance.set ['sm9', 'sm14']
  end

  describe "uri" do
    subject { @instance.uri }
    specify {
      expect(subject).to match /http:\/\/i\.nicovideo\.jp\/v3\/video\.array\?v=((sm\d|nm\d),{0,}){1,}/
    }
  end
end