require "nicoquery/object/tag_search"
require "fixture/tag_search_yukkuri_page1"


describe "NicoQuery::Object::TagSearch" do
  before do
    WebMock.stub_request(:get, "http://www.nicovideo.jp/tag/%E3%82%86%E3%81%A3%E3%81%8F%E3%82%8A%E5%AE%9F%E6%B3%81%E3%83%97%E3%83%AC%E3%82%A4?numbers=1&order=a&page=1&rss=2.0&sort=f").
         with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => Fixture.tag_search_yukkuri_page1, :headers => {})

    @tag_search_result = NicoQuery::Object::TagSearch.new( tag: "ゆっくり実況プレイ",
                                                           sort: :published_at,
                                                           order: :asc,
                                                           page: 1 )
  end

  subject { @tag_search_result }

  describe "title" do
    it "returns string of title" do
      expect(subject.title).to eq "ゆっくり実況プレイ"
    end
  end

  describe "movies" do
    it "returns movie instances" do
      expect(subject.movies).to be_an_instance_of Array
      expect(subject.movies[0]).to be_an_instance_of NicoQuery::Object::Movie
    end
  end
end
