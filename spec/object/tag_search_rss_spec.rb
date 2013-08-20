require "nicoquery/object/tag_search"


describe "NicoQuery::Object::TagSearch" do
  before do
    @tag_search_result = NicoQuery::Object::TagSearch.new( tag: "ゆっくり実況プレイ",
                                                           sort: :published_at,
                                                           order: :asc,
                                                           page: 1 )
  end

  subject { @tag_search_result }

  describe "title" do
    it "returns string of title" do
      binding.pry
      expect(subject.title).to eq "to_test"
    end
  end

  describe "movies" do
    it "returns movie instances" do
      expect(subject.movies).to be_an_instance_of Array
      expect(subject.movies[0]).to be_an_instance_of NicoQuery::Object::Movie
    end
  end
end
