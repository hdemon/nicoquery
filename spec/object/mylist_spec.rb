require "nicoquery/object/mylist"


describe "NicoQuery::Object::Mylist" do
  before do
    # mylist:38369702 はテスト用に作ったマイリスト。以下の動画を含んでいる。
    # sm9 新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師
    # sm1097445 【初音ミク】みくみくにしてあげる♪【してやんよ】
    @mylist = NicoQuery::Object::Mylist.new('38369702')
  end

  describe "movies" do
    it "returns movie instances" do
      expect(@mylist.movies).to be_an_instance_of Array
      expect(@mylist.movies[0]).to be_an_instance_of NicoQuery::Object::Movie
    end
  end

  describe "title" do
    subject { @mylist }
    it "returns string of title" do
      expect(subject.title).to eq "to_test"
    end
  end

  describe "url" do
    subject { @mylist }
    it "returns string of url" do
      expect(subject.url).to eq "http://www.nicovideo.jp/mylist/38369702"
    end
  end

  describe "mylist_id" do
    subject { @mylist }
    it "returns number of mylist_id" do
      expect(subject.mylist_id).to eq 38369702
    end
  end

  describe "description" do
    subject { @mylist }
    it "returns string of title" do
      # mylistのrssでは、descriptionの全文取得はできず、頭から256文字までしか取得できない。
      expect(subject.description).to eq "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nam cursus. Morbi ut mi. Nullam enim leo, egestas id, condimentum at, laoreet mattis, massa. Sed eleifend nonummy diam. Praesent mauris ante, elementum et, bibendum at, posuere sit amet, nibh. Duis "
    end
  end
end
