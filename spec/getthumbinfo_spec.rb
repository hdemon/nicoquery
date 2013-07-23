require './app/getthumbinfo'


describe "getthumbinfo" do
  describe "get" do
    before do
      @instance = NicoAPI::GetThumbInfo.new
      @instance.set video_id: 'sm9'
    end

    subject { @instance.uri }
    it do
       expect(subject).to be
    end
  end
end
