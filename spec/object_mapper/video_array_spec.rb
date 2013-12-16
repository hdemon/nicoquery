require "nicoquery/object_mapper/video_array"
require "fixture/video_array_sm20415650_sm9"
require "fixture/video_array_no_tags"


describe "NicoQuery::ObjectMapper::VideoArray" do

  context "sm20415650" do
    before do
      xml = Fixture.video_array_sm20415650_sm9
      @result = NicoQuery::ObjectMapper::VideoArray.new xml
    end

    subject { @result.movies[0] }

    describe "#title" do
      it "returns string of title" do
        expect(subject.title).to eq "【Minecraft】まったりクラフター生活 ～最終日～【ゆっくり実況】"
      end
    end

    describe "#video_id" do
      it "returns number of mylist_id" do
        expect(subject.video_id).to eq "sm20415650"
      end
    end

    describe "#thread_id" do
      it "returns number of mylist_id" do
        expect(subject.thread_id).to eq 1364047834
      end
    end

    describe "#publish_date" do
      it "returns number of thread_id" do
        expect(subject.publish_date).to eq Time.new(2013, 3, 23, 23, 10, 32)
      end
    end

    describe "#thumbnail_url" do
      it "returns number of thread_id" do
        expect(subject.thumbnail_url).to eq "http://tn-skr3.smilevideo.jp/smile?i=20415650"
      end
    end

    describe "#view_counter" do
      it "returns number of view counter" do
        expect(subject.view_counter).to be_a_kind_of(Fixnum)
      end
    end

    describe "#comment_num" do
      it "returns number of comment num" do
        expect(subject.comment_num).to be_a_kind_of(Fixnum)
      end
    end

    describe "#mylist_counter" do
      it "returns number of mylist counter" do
        expect(subject.mylist_counter).to be_a_kind_of(Fixnum)
      end
    end

    describe "#description.raw_text" do
      it "returns string of title" do
        # mylistのrssでは、descriptionの全文取得はできず、頭から256文字までしか取得できない。
        # <br />が勝手に<br></br>に変換されてしまう。noriのせい？
        expect(subject.description.raw_text).to eq "最終日。<br></br><br></br>ひっそりまったり通常営業...かな？<br></br>ついにきました最終日。最後に最長の尺...画質が悪いかもです＞＜<br></br>今まで本当にありがとうございました！最後にゆっくりまったりしていってね（*´ヮ｀*）<br></br><br></br>シード値：－2086770116<br></br><br></br>使用MOD<br></br>1.Opti Fine<br></br>2.MinecraftIM<br></br>3.PlayerFormLittleMaid<br></br>4.Audiotori r2<br></br>5.littleMaidMob<br></br>＋りばいあ製MOD×2(らいちんぐすてっき・ゆかり＆らいちロボ)<br></br><br></br>sm20221817←２９日目⇔新シリーズ→sm21615389<br></br><br></br>シリーズまとめ→mylist/29017292<br></br>他に作ったもの→mylist/29022355<br></br><br></br>twitter⇒http://twitter.com/raichi_J<br></br>コミュco1590050<br></br><br></br>いただいたイラストclip/577830<br></br>ゆかりテクスチャim2807664<br></br>moyuさん作・ゆかりさんと私のメイドモデルim2466837"
#         expect(subject.description.raw_text).to eq <<-EOS
# 最終日。<br /><br />ひっそりまったり通常営業...かな？<br />ついにきました最終日。最後に最長の尺...画質が悪いかもです＞＜<br />今まで本当にありがとうございました！最後にゆっくりまったりしていってね（*´ヮ｀*）<br /><br />シード値：－2086770116<br /><br />使用MOD<br />1.Opti Fine<br />2.MinecraftIM<br />3.PlayerFormLittleMaid<br />4.Audiotori r2<br />5.littleMaidMob<br />＋りばいあ製MOD×2(らいちんぐすてっき・ゆかり＆らいちロボ)<br /><br />sm20221817←２９日目⇔新シリーズ→sm21615389<br /><br />シリーズまとめ→mylist/29017292<br />他に作ったもの→mylist/29022355<br /><br />twitter⇒http://twitter.com/raichi_J<br />コミュco1590050<br /><br />いただいたイラストclip/577830<br />ゆかりテクスチャim2807664<br />moyuさん作・ゆかりさんと私のメイドモデルim2466837
#         EOS
      end
    end

    describe "#description.mylist_references" do
      it "returns number of mylist references" do
        expect(subject.description.mylist_references).to eq [29017292, 29022355]
      end
    end

    describe "#tags" do
      it "returns number of mylist references" do
        expect(subject.tags).to be_a_kind_of Array
      end
    end
  end

  context "when a movie doesn't contain more than one tag" do
    before do
      xml = Fixture.video_array_sm20415650_sm9
      @result = NicoQuery::ObjectMapper::VideoArray.new xml
    end

    subject { @result.movies[0] }

    describe "#tags" do
      it "returns number of mylist references" do
        expect(subject.tags).to be_a_kind_of Array
      end
    end
  end

  context "when a movie contains no tag" do
    before do
      xml = Fixture.video_array_no_tags
      @result = NicoQuery::ObjectMapper::VideoArray.new xml
    end

    subject { @result.movies[0] }

    describe "#tags" do
      it "returns empty array" do
        expect(subject.tags).to be_a_kind_of Array
        expect(subject.tags).to be_empty
      end
    end
  end

end
