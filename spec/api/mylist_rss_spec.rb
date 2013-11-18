require 'nicoquery/api/mylist_rss'
require 'fixture/mylist_rss_18266317'
require 'webmock/rspec'


describe "mylist_rss" do
  describe "when access an existing and public mylist" do
    before do
      WebMock.enable!
      WebMock.stub_request(:get, "http://www.nicovideo.jp/mylist/18266317?numbers=1&rss=2.0").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => Fixture.mylist_rss_18266317, :headers => {})

      mylist_id = 18266317
      @uri = "http://www.nicovideo.jp/mylist/#{mylist_id}?rss=2.0&numbers=1"
      @instance = NicoQuery::Api::MylistRSS.new mylist_id
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

