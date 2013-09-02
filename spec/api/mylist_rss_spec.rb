require 'nicoquery/api/mylist_rss'
require 'fixture/mylist_rss_18266317'
require 'webmock/rspec'


describe "mylist_rss" do
  describe "when access an existing and public mylist" do
    before do
      @mylist_id = 18266317
      @uri = "http://www.nicovideo.jp/mylist/#{@mylist_id}?rss=2.0&numbers=1"
      @instance = NicoQuery::Api::MylistRSS.new @mylist_id
      WebMock.stub_request :get, @uri
      # WebMock.reset!
    end

    after(:all) do
      WebMock.disable!
    end

    describe "get" do
      before do
        @instance.get
      end

      it "should GET mylist rss resource" do
        WebMock.should have_requested :get, @uri
      end
    end

    describe "uri" do
      subject { @instance.uri }

      specify { expect(subject).to match /http:\/\/www\.nicovideo\.jp\/mylist/ }
      specify { expect(subject).to match /18266317/ }
      specify { expect(subject).to match /rss\=2\.0/ }
    end
  end
end

