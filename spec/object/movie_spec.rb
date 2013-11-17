require 'nicoquery/object/movie'
require 'fixture/getthumbinfo_deleted'
require 'fixture/getthumbinfo_community'
require 'fixture/getthumbinfo_notfound'
require 'webmock/rspec'


describe "NicoQuery::Object::Movie" do
  context "when specified video id and this movie is exist" do
    before do
      # mylist:38369702 はテスト用に作ったマイリスト。以下の動画を含んでいる。
      # sm9 新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師
      # sm1097445 【初音ミク】みくみくにしてあげる♪【してやんよ】
      @movie = NicoQuery::Object::Movie.new('sm9')
    end

    subject { @movie }

    describe "#deleted?" do
      it "returns false" do
        expect(subject.deleted?).to be_false
      end
    end

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

  context "when specified video id and this movie is exist" do
    before do
      # thread_id:1173108780 == video_id:sm9
      @movie = NicoQuery::Object::Movie.new(1173108780)
    end

    subject { @movie }

    describe "title" do
      it "returns string of title" do
        expect(subject.title).to eq "新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師"
      end
    end
  end

  context "when specified movie is deleted" do
    before do
      WebMock.enable!
      WebMock.stub_request(:get, "http://ext.nicovideo.jp/api/getthumbinfo/sm999999?").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => Fixture.getthumbinfo_deleted, :headers => {})

      @movie = NicoQuery::Object::Movie.new('sm999999')
    end

    subject { @movie }

    describe "#deleted?" do
      it "returns true" do
        expect(subject.deleted?).to be_true
      end
    end

    describe "getter methods" do
      specify "all returns nil" do
        expect(subject.title).to be_nil
        expect(subject.url).to be_nil
        expect(subject.view_counter).to be_nil
        expect(subject.tags).to be_nil
      end
    end
  end

  context "when specified movie belongs to community" do
    before do
      WebMock.enable!
      WebMock.stub_request(:get, "http://ext.nicovideo.jp/api/getthumbinfo/sm99999901?").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => Fixture.getthumbinfo_community, :headers => {})

      @movie = NicoQuery::Object::Movie.new('sm99999901')
    end

    after do
      WebMock.disable!
    end

    subject { @movie }

    describe "#community?" do
      it "returns true" do
        expect(subject.community?).to be_true
      end
    end

    describe "getter methods" do
      specify "all returns nil" do
        expect(subject.title).to be_nil
        expect(subject.url).to be_nil
        expect(subject.view_counter).to be_nil
        expect(subject.tags).to be_nil
      end
    end
  end

  context "when specified movie doesn't exist" do
    before do
      WebMock.enable!
      WebMock.stub_request(:get, "http://ext.nicovideo.jp/api/getthumbinfo/sm99999901?").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => Fixture.getthumbinfo_notfound, :headers => {})

      @movie = NicoQuery::Object::Movie.new('sm99999901')
    end

    after do
      WebMock.disable!
    end

    subject { @movie }

    describe "#exist?" do
      it "returns false" do
        expect(subject.exist?).to be_false
      end
    end

    describe "getter methods" do
      specify "all returns nil" do
        expect(subject.title).to be_nil
        expect(subject.url).to be_nil
        expect(subject.view_counter).to be_nil
        expect(subject.tags).to be_nil
      end
    end
  end
end
