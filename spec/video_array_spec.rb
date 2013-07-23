require './app/video_array'

describe "VideoArray" do
  before do
    @instance = NicoAPI::VideoArray.new
    @instance.set ['sm9', 'sm9']
  end

  describe "uri" do
    subject { @instance.uri }
    it {
      expect(subject).to be
    }
  end
end