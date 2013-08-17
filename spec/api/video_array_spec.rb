require 'nicoquery/api/video_array'


describe "VideoArray" do
  before do
    @instance = NicoQuery::Api::VideoArray.new ['sm9', 'sm14']
  end

  describe "uri" do
    subject { @instance.uri }
    specify {
      expect(subject).to match /http:\/\/i\.nicovideo\.jp\/v3\/video\.array\?v=((sm\d|nm\d),{0,}){1,}/
    }
  end
end
