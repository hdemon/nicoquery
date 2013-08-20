require "nicoquery"
require "pry"


describe "NicoQuery" do
  # TODO: object/mylist_spec.rbのコピペなのでDRYに。
  describe "mylist" do
    before do
      # mylist:38369702 はテスト用に作ったマイリスト。以下の動画を含んでいる。
      # sm9 新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師
      # sm1097445 【初音ミク】みくみくにしてあげる♪【してやんよ】
      @mylist = NicoQuery.mylist('38369702')
    end

    subject { @mylist }

    it "returns NicoQuery::Object::Mylist instance" do
      expect(subject).to be_an_instance_of NicoQuery::Object::Mylist
    end

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
  end

  describe "movie" do
    before do
      # mylist:38369702 はテスト用に作ったマイリスト。以下の動画を含んでいる。
      # sm9 新・豪血寺一族 -煩悩解放 - レッツゴー！陰陽師
      # sm1097445 【初音ミク】みくみくにしてあげる♪【してやんよ】
      @movie = NicoQuery::Object::Movie.new('sm9')
    end

    subject { @movie }

    it "returns NicoQuery::Object::Movie instance" do
      expect(subject).to be_an_instance_of NicoQuery::Object::Movie
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
      it "returns movie instances" do
        expect(@movie.tags).to be_an_instance_of Array
      end
    end
  end

  describe "tag_search" do
    before do
      counter = 0
      @acquired_movies = []

      NicoQuery.tag_search(  tag: "ゆっくり実況プレイ",
                             sort: :published_at,
                             order: :asc
                          ) do |result|
        counter += 1
        @acquired_movies.push result
        if counter >= 50 then :break else :continue end
      end
    end

    subject { @acquired_movies }

    specify "it returns NicoQuery::Object::Movie instance in the block" do
      expect(subject[0]).to be_an_instance_of NicoQuery::Object::Movie
    end
  end

end