require 'nicoquery/api/mylist_rss'


describe "mylist_rss" do
  before do
    @instance = NicoQuery::Api::MylistRSS.new 18266317
  end

  describe "uri" do
    subject { @instance.uri }

    specify { expect(subject).to match /http:\/\/www\.nicovideo\.jp\/mylist/ }
    specify { expect(subject).to match /18266317/ }
    specify { expect(subject).to match /rss\=2\.0/ }
  end
end