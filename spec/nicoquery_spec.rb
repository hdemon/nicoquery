require "nicoquery"
require "fixture/mylist_rss_normal"


describe "NicoQuery" do
  # TODO: object/mylist_spec.rbのコピペなのでDRYに。
  describe "mylist" do
    before do
      WebMock.stub_request(:get, "http://www.nicovideo.jp/mylist/38369702?numbers=1&rss=2.0").
        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => Fixture.mylist_rss_normal, :headers => {})
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
    context "when passed a string of video id to argument" do
      before do
        @movie = NicoQuery.movie('sm9')
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

    context "when passed an string array of video id to argument" do
      before do
        WebMock.stub_request(:get, "http://i.nicovideo.jp/v3/video.array?v=sm20415650,sm9").
          with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => "", :headers => {})

        @movie = NicoQuery.movie(['sm20415650', 'sm9'])
      end

      subject { @movie }

      it "returns array of NicoQuery::Object::Movie instance" do
        expect(subject).to be_an_instance_of Array
        expect(subject[0]).to be_an_instance_of NicoQuery::Object::Movie
        expect(subject[1]).to be_an_instance_of NicoQuery::Object::Movie
      end

    end
  end

  # TODO: tag_searchで同等の内容をテストしているので、ここではメソッド呼び出しの過程のみをテストすべき。
  # describe "tag_search" do
  #   before do
  #     counter = 0
  #     @acquired_movies = []

  #     WebMock.stub_request(:get, "http://www.nicovideo.jp/tag/%E3%82%86%E3%81%A3%E3%81%8F%E3%82%8A%E5%AE%9F%E6%B3%81%E3%83%97%E3%83%AC%E3%82%A4?numbers=1&order=a&page=1&rss=2.0&sort=f").
  #        with(:headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
  #        to_return(:status => 200, :body => "", :headers => {})

  #     NicoQuery.tag_search(  tag: "ゆっくり実況プレイ",
  #                            sort: :published_at,
  #                            order: :asc
  #                         ) do |result|
  #       counter += 1
  #       @acquired_movies.push result
  #       if counter >= 50 then :break else :continue end
  #     end
  #   end

  #   subject { @acquired_movies }

  #   specify "it returns NicoQuery::Object::Movie instance in the block" do
  #     expect(subject[0]).to be_an_instance_of NicoQuery::Object::Movie
  #   end
  # end
end
