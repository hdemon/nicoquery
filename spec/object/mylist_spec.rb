require "nicoquery/object/mylist"
require "fixture/mylist_rss_403"


describe "NicoQuery::Object::Mylist" do
  context "when specified mylist exists and is public" do
    before do
      WebMock.disable!
      # mylist:38369702 はテスト用に作ったマイリスト。以下の動画を含んでいる。
      # sm9 新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師
      # sm1097445 【初音ミク】みくみくにしてあげる♪【してやんよ】
      @mylist = NicoQuery::Object::Mylist.new(38369702)
    end

    subject { @mylist }

    describe "movies" do
      it "returns movie instances" do
        expect(subject.movies).to be_an_instance_of Array
        expect(subject.movies[0]).to be_an_instance_of NicoQuery::Object::Movie
      end
    end

    describe "title" do
      it "returns string of title" do
        expect(subject.title).to eq "to_test"
      end
    end

    describe "url" do
      it "returns string of url" do
        expect(subject.url).to eq "http://www.nicovideo.jp/mylist/38369702"
      end
    end

    describe "mylist_id" do
      it "returns number of mylist_id" do
        expect(subject.mylist_id).to eq 38369702
      end
    end

    describe "description" do
      it "returns string of title" do
        # mylistのrssでは、descriptionの全文取得はできず、頭から256文字までしか取得できない。
        expect(subject.description).to eq "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nam cursus. Morbi ut mi. Nullam enim leo, egestas id, condimentum at, laoreet mattis, massa. Sed eleifend nonummy diam. Praesent mauris ante, elementum et, bibendum at, posuere sit amet, nibh. Duis "
      end
    end

    describe "#available?" do
      it "returns true" do
        expect(subject.available?).to be_true
      end
    end

    describe "#exist?" do
      it "returns true" do
        expect(subject.exist?).to be_true
      end
    end

    describe "tags" do
      it "returns object array" do
        expect(subject.movies[0].tags).to be_an_instance_of Array
      end

      specify "each object has text and lock key-value" do
        expect(subject.movies[0].tags).to include(text: '音楽', lock: true)
      end
    end

  end

  context "when access for specified mylist is forbidden" do
    before do
      WebMock.enable!
      WebMock.stub_request(:get, "http://www.nicovideo.jp/mylist/999999?rss=2.0&numbers=1").
        to_return(:status => 403, :body => Fixture.mylist_rss_403, :headers => {})

      @mylist = NicoQuery::Object::Mylist.new(999999)
    end

    subject { @mylist }

    describe "#forbidden?" do
      it "returns true" do
        expect(subject.forbidden?).to be_true
      end
    end

    describe "#available?" do
      it "returns false" do
        expect(subject.available?).to be_false
      end
    end

    describe "#exist?" do
      it "returns true" do
        expect(subject.exist?).to be_true
      end
    end

    describe "getter methods" do
      specify "all returns nil or empty array" do
        expect(subject.title).to be_nil
        expect(subject.url).to be_nil
        expect(subject.link).to be_nil
        expect(subject.description).to be_nil
        expect(subject.publish_date).to be_nil
        expect(subject.last_build_date).to be_nil
        expect(subject.creator).to be_nil

        expect(subject.movies).to eql []
      end
    end
  end

  context "when access for mylist that doesn't exist" do
    before do
      WebMock.enable!
      WebMock.stub_request(:get, "http://www.nicovideo.jp/mylist/999999?rss=2.0&numbers=1").
        to_return(:status => 404, :body => "", :headers => {})

      @mylist = NicoQuery::Object::Mylist.new(999999)
    end

    subject { @mylist }

    describe "#forbidden?" do
      it "returns false" do
        expect(subject.forbidden?).to be_false
      end
    end

    describe "#available?" do
      it "returns false" do
        expect(subject.available?).to be_false
      end
    end

    describe "#exist?" do
      it "returns false" do
        expect(subject.exist?).to be_false
      end
    end

    describe "getter methods" do
      specify "all returns nil or empty array" do
        expect(subject.title).to be_nil
        expect(subject.url).to be_nil
        expect(subject.link).to be_nil
        expect(subject.description).to be_nil
        expect(subject.publish_date).to be_nil
        expect(subject.last_build_date).to be_nil
        expect(subject.creator).to be_nil

        expect(subject.movies).to eql []
      end
    end
  end
end
