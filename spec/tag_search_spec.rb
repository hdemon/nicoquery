require './app/tag_search'

describe "tag_search" do
  describe "execute" do
    before do
      instance = NicoAPI::TagSearch.new
      instance.set tag: 'ゆっくり実況プレイ', sort: 'published_at', order: 'asc'
      @result = instance.get
    end

    it "should get tag's xml" do
      @result
    end
  end
end