require "nicoquery/crawler"


describe "NicoQuery" do
  describe "tag_search" do
    before do
      counter = 0
      @acquired_movies = []

      NicoQuery::Crawler::TagSearch.execute( tag: "ゆっくり実況プレイ",
                            sort: :published_at,
                            order: :asc
                          ) do |result|
        counter += 1
        @acquired_movies.push result
        if counter >= 50 then :break else :continue end
      end
    end

    it "should sorted by published date" do
      expect(@acquired_movies[0].publish_date).to be < @acquired_movies[1].publish_date
    end

    it "should scrape movie's info the number of times -1 that returns :continue" do
      expect(@acquired_movies.length).to eq 50
    end
  end
end
