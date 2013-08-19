require "nicoquery/object/movie"


describe "NicoQuery::Object::Movie" do
  before do
    # mylist:38369702 はテスト用に作ったマイリスト。以下の動画を含んでいる。
    # sm9 新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師
    # sm1097445 【初音ミク】みくみくにしてあげる♪【してやんよ】
    @movie = NicoQuery::Object::Movie.new('sm9')
  end

  subject { @movie }

  describe "title" do
    it "returns string of title" do
      expect(subject.title).to eq "新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師"
    end
  end

  describe "url" do
    it "returns string of url" do
      expect(subject.url).to eq "http://www.nicovideo.jp/watch/sm9"
    end
  end

  describe "video_id" do
    it "returns number of mylist_id" do
      expect(subject.video_id).to eq "sm9"
    end
  end

  # describe "description" do
  #   subject { @movie }
  #   it "returns string of title" do
  #     # mylistのrssでは、descriptionの全文取得はできず、頭から256文字までしか取得できない。
  #     expect(subject.description).to eq "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nam cursus. Morbi ut mi. Nullam enim leo, egestas id, condimentum at, laoreet mattis, massa. Sed eleifend nonummy diam. Praesent mauris ante, elementum et, bibendum at, posuere sit amet, nibh. Duis "
  #   end
  # end

  describe "tags" do
    subject { @movie.tags }

    it "returns object array" do
      expect(subject).to be_an_instance_of Array
    end

    specify "each object has text and lock key-value" do
      expect(subject).to include(text: '陰陽師', lock: true)
    end
  end
end
p