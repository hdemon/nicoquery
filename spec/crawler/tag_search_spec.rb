require "nicoquery/crawler/tag_search"
require "fixture/tag_search_yukkuri_page1"
require "fixture/tag_search_yukkuri_page2"


describe "NicoQuery:Crawler" do
  describe "tag_search" do
    before do
      counter = 0
      @acquired_movies = []

      WebMock.stub_request(:get, "http://www.nicovideo.jp/tag/%E3%82%86%E3%81%A3%E3%81%8F%E3%82%8A%E5%AE%9F%E6%B3%81%E3%83%97%E3%83%AC%E3%82%A4?numbers=1&order=a&page=1&rss=2.0&sort=f").
         with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => Fixture.tag_search_yukkuri_page1, :headers => {})

      WebMock.stub_request(:get, "http://www.nicovideo.jp/tag/%E3%82%86%E3%81%A3%E3%81%8F%E3%82%8A%E5%AE%9F%E6%B3%81%E3%83%97%E3%83%AC%E3%82%A4?numbers=1&order=a&page=2&rss=2.0&sort=f").
         with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => Fixture.tag_search_yukkuri_page2, :headers => {})

      NicoQuery::Crawler::TagSearch.execute( tag: "ゆっくり実況プレイ",
                                             sort: :published_at,
                                             order: :asc
                                           ) do |result|
        counter += 1
        @acquired_movies.push result
        if counter >= 50 then :break else :continue end
      end
    end

    specify "it returns NicoQuery::Object::Movie instance in the block" do
      expect(@acquired_movies[0]).to be_an_instance_of NicoQuery::Object::Movie
    end

    it "should sorted by published date" do
      expect(@acquired_movies[0].publish_date).to be < @acquired_movies[1].publish_date
    end

    it "should scrape movie's info the number of times -1 that returns :continue" do
      expect(@acquired_movies.length).to eq 50
    end
  end
end
