require "nicoquery/crawler/bulk_scraping"


describe "NicoQuery::Crawler" do
  describe "VideoArray" do
    before do
      @acquired_movies = []
      WebMock.disable! # TODO: WebMockを利用する。
      NicoQuery::Crawler::BulkScraping.execute(['sm20415650', 'sm9']) do |result|
        @acquired_movies.push result
      end
    end

    it "should sorted by published date" do
      expect(@acquired_movies[0].publish_date).to be
    end

    it "should scrape movie's info the number of times -1 that returns :continue" do
      expect(@acquired_movies.length).to eq 2
    end
  end
end
