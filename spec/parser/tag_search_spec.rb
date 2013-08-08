require "spec_helper"
require "./lib/nicoquery/parser/tag_search"
require "./spec/parser/fixture"


describe "NicoQuery::Parser" do
  describe "TagSearch" do
    before do
      @instance = NicoQuery::Parser::TagSearch.new
      @instance.parse Fixture.tag_search_rss
    end

    shared_examples "url string" do
      specify { expect(subject).to match /(http|https)\:\/\/.+/ }
    end

    describe "tag" do
      subject { @instance.tag }
      specify { expect(subject).to be }
    end

    describe "publish_date" do
      subject { @instance.publish_date }
      specify { expect(subject).to be_kind_of(Time) }
    end

    describe "last_build_date" do
      subject { @instance.last_build_date }
      specify { expect(subject).to be_kind_of(Time) }
    end

    describe "item" do
      subject { @instance.items }
      specify { expect(subject).to be_kind_of(Array) }
    end

    describe "each item" do

      describe "title" do
        subject { @instance.items[0].title }
        specify { expect(subject).to be }
      end

      describe "video_id" do
        subject { @instance.items[0].video_id }
        specify { expect(subject).to match /(sm|nm)\d{1,}/ }
      end

      describe "url" do
        subject { @instance.items[0].url }
        it_behaves_like "url string"
      end

      describe "publish_date" do
        subject { @instance.items[0].url }
        it_behaves_like "url string"
      end

      describe "thumbnail_url" do
        subject { @instance.items[0].thumbnail_url }
        it_behaves_like "url string"
      end

      describe "length" do
        subject { @instance.items[0].length }
        specify { expect(subject).to be_kind_of(Fixnum) }
      end

      describe "description" do
        subject { @instance.items[0].description }
        specify { expect(subject).to be_kind_of(Object) }
      end

      describe "Description" do
        describe "raw_text" do
          subject { @instance.items[0].description.raw_text }
          specify { expect(subject).to be_kind_of(String) }
        end

        describe "text" do
          subject { @instance.items[0].description.text }
          specify { expect(subject).to be_kind_of(String) }
        end

        # spec/fixture.rbを参照。
        describe "movie_references" do
          subject { @instance.items[5].description.movie_references }
          specify { expect(subject).to be_kind_of(Array) }
          specify { expect(subject.length).to eq 4 }
          specify { expect(subject[0]).to match /^(sm|nm)\d{1,}$/ }
        end

        # Fixtureの最初の動画では、'mylist/(数字)'の記載が2つある。
        describe "mylist_references" do
          subject { @instance.items[0].description.mylist_references }
          specify { expect(subject).to be_kind_of(Array) }
          specify { expect(subject.length).to eq 2 }
          specify { expect(subject[0]).to match /^\d{1,}$/ }
        end

        # Fixtureの3番目の動画では、'co(数字)'の記載が2つある。
        describe "community_references" do
          subject { @instance.items[2].description.community_references }
          specify { expect(subject).to be_kind_of(Array) }
          specify { expect(subject.length).to eq 1 }
          specify { expect(subject[0]).to match /^co\d{1,}$/ }
        end

        # Fixtureの3番目の動画では、'im(数字)'の記載が1つある。
        describe "seiga_references" do
          subject { @instance.items[3].description.seiga_references }
          specify { expect(subject).to be_kind_of(Array) }
          specify { expect(subject.length).to eq 1 }
          specify { expect(subject[0]).to match /^im\d{1,}$/ }
        end
      end
    end
  end
end