require "nicoquery/object_mapper/getthumbinfo"
require "fixture/getthumbinfo_sm20415650"


describe "NicoQuery::ObjectMapper::MylistRss" do
  before do
    xml = Fixture.getthumbinfo_sm20415650
    @hash = NicoQuery::ObjectMapper::GetThumbInfo.new xml
  end

  subject { @hash }

  describe "#title" do
    it "returns string of title" do
      expect(subject.title).to eq "【Minecraft】まったりクラフター生活 ～最終日～【ゆっくり実況】"
    end
  end

  describe "#url" do
    it "returns string of url" do
      expect(subject.url).to eq "http://www.nicovideo.jp/watch/sm20415650"
    end
  end

  describe "#video_id" do
    it "returns number of mylist_id" do
      expect(subject.video_id).to eq "sm20415650"
    end
  end

  describe "#publish_date" do
    it "returns number of thread_id" do
      # expect(subject.video_id).to eq Time(2013, 8, 18, 2, 13, 47)
    end
  end

  describe "#thumbnail_url" do
    it "returns number of thread_id" do
      expect(subject.thumbnail_url).to eq "http://tn-skr3.smilevideo.jp/smile?i=20415650"
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
      expect(subject.description.mylist_references).to eq [29017292, 29022355]
    end
  end

end
