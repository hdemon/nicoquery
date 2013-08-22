require 'nicoquery/api/tag_search_rss'


describe "tag_search" do
  before do
    @instance = NicoQuery::Api::TagSearchRss.new  tag: 'ゆっくり実況プレイ',
                                                sort: :published_at,
                                                order: :asc,
                                                page: 1
  end

  describe "uri" do
    subject { @instance.uri }

    specify { expect(subject).to match /http:\/\/www\.nicovideo\.jp\/tag/ }

    specify { expect(subject).to match /(sort=(v|r|m|f|l)){0,}/ }
    specify { expect(subject).to match /(order=(a|d)){0,}/ }
    specify { expect(subject).to match /(page=\d){1,}/ }
    specify { expect(subject).to match /rss\=2\.0/ }
  end
end