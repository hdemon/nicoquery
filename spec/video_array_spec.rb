require './app/video_array'

describe "VideoArray" do
  before do
    @instance = NicoAPI::VideoArray.new
    @instance.set ['sm9', 'sm9']
    puts @instance.get
  end

  describe "uri" do
    subject { @instance.uri }
    it {
      puts subject
      expect(subject).to be
    }
  end
end