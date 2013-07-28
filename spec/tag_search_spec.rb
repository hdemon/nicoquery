require 'nicoapi/tag_search'


describe "tag_search" do
  before do
    @instance = NicoAPI::TagSearch.new
    @instance.set tag: 'ゆっくり実況プレイ', sort: :published_at, order: :asc
  end

  describe "uri" do
    subject { @instance.uri }
    specify {
      # host and path
      expect(subject).to match /http:\/\/www\.nicovideo\.jp\/tag/
      # uri parameter
      expect(subject).to match /\?(sort=(v|r|m|f|l)){0,}/
      expect(subject).to match /\?(order=(a|d)){0,}/
    }
  end
end