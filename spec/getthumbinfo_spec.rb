require './app/getthumbinfo'


describe "getthumbinfo" do
  describe "get" do
    before do
      @instance = NicoAPI::GetThumbInfo.new
      @instance.set video_id: 'sm9'
    end

    subject { @instance.uri }
    specify {
      expect(subject).to match /http:\/\/ext\.nicovideo\.jp\/api\/getthumbinfo\/(sm|nm)\d/
    }
  end
end
