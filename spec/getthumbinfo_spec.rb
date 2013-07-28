require 'nicoapi/getthumbinfo'


describe "getthumbinfo" do
  before do
    @instance = NicoAPI::GetThumbInfo.new
    @instance.set 'sm9'
  end

  describe "uri" do
    subject { @instance.uri }
    specify {
      expect(subject).to match /http:\/\/ext\.nicovideo\.jp\/api\/getthumbinfo\/(sm|nm)\d/
    }
  end
end
