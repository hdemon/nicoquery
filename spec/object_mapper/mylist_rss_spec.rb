require "nicoquery/object_mapper/mylist_rss"
require "fixture/mylist_rss_18266317"


describe "NicoQuery::ObjectMapper::MylistRss" do
  before do
    # mylist:38369702 はテスト用に作ったマイリスト。以下の動画を含んでいる。
    # sm9 新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師
    # sm1097445 【初音ミク】みくみくにしてあげる♪【してやんよ】
    xml = Fixture.mylist_rss_18266317
    @mylist_rss = NicoQuery::ObjectMapper::MylistRSS.new xml
  end

  subject { @mylist_rss.items[1] }

  describe "#title" do
    it "returns string of title" do
      expect(subject.title).to eq "【Minecraft】GREEN'S CRAFT Part1【ゆっくり&amp;VOICEROID+実況】"
    end
  end

  describe "#url" do
    it "returns string of url" do
      expect(subject.url).to eq "http://www.nicovideo.jp/watch/sm21615389"
    end
  end

  describe "#video_id" do
    it "returns number of mylist_id" do
      expect(subject.video_id).to eq "sm21615389"
    end
  end

  describe "#thread_id" do
    it "returns number of thread_id" do
      expect(subject.thread_id).to eq 1376736501
    end
  end

  describe "#publish_date" do
    it "returns number of thread_id" do
      # expect(subject.video_id).to eq Time(2013, 8, 18, 2, 13, 47)
    end
  end

  describe "#thumbnail_url" do
    it "returns number of thread_id" do
      expect(subject.thumbnail_url).to eq "http://tn-skr2.smilevideo.jp/smile?i=21615389"
    end
  end

  # describe "#view_counter" do
  #   it "returns number of view counter" do
  #     expect(subject.view_counter).to be_a_kind_of(Fixnum)
  #   end
  # end

  # describe "#comment_num" do
  #   it "returns number of comment num" do
  #     expect(subject.comment_num).to be_a_kind_of(Fixnum)
  #   end
  # end

  # describe "#mylist_counter" do
  #   it "returns number of mylist counter" do
  #     expect(subject.mylist_counter).to be_a_kind_of(Fixnum)
  #   end
  # end

  # describe "description" do
  #   subject { @movie }
  #   it "returns string of title" do
  #     # mylistのrssでは、descriptionの全文取得はできず、頭から256文字までしか取得できない。
  #     expect(subject.description).to eq "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nam cursus. Morbi ut mi. Nullam enim leo, egestas id, condimentum at, laoreet mattis, massa. Sed eleifend nonummy diam. Praesent mauris ante, elementum et, bibendum at, posuere sit amet, nibh. Duis "
  #   end
  # end

  describe "#description.mylist_references" do
    it "returns number of mylist references" do
      expect(subject.description.mylist_references).to eq [38367203, 29017292, 29022355]
    end
  end

end
